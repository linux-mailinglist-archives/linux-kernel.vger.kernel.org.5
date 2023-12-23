Return-Path: <linux-kernel+bounces-10325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2F5D81D2C3
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 07:49:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42C262859DD
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 06:49:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1E8063C1;
	Sat, 23 Dec 2023 06:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="kWonu6Xa"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A14E16116;
	Sat, 23 Dec 2023 06:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1703314099; x=1703918899; i=w_armin@gmx.de;
	bh=a0HQXaAtb5AyLWRvBbN6Jqobrx6+zPwHEGHfiXoJBIE=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=kWonu6Xa2gA3BAvixi8R2DAMrkXn1Xqty+YVMKqBGB3psUqGBbMdupl0tRXIiZ3F
	 i+wa+9pXi+BV6BLkKzaf0KMe3WezyrCPzteQ9IB72vAZwaePl9Ya7tjDId+kPjw9L
	 PxWzkdQQXC0ko0qNL0ms1Sr4JnNAZHA2gqR2FRdkkb25HmI9XwTVvloUuVyBYlgi7
	 fpuUedTDPL6JiQVf3F8EcT4OcaUnw1GxaYy/X99s9nvOHydBq60Oia8JFCrmrilSe
	 DX2x0APqLxGbsCSTAvQqUVKwKPzZnW0jNmssla35sCXYagl/13UFcQ+Uwqx5rr7G1
	 zbQ4bcu4jHBK60HsJQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [141.30.226.129] ([141.30.226.129]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MybKf-1r54M23Da9-00yzor; Sat, 23
 Dec 2023 07:48:19 +0100
Message-ID: <1dd56bfa-ce60-4037-bb1e-0d1676d4e8ce@gmx.de>
Date: Sat, 23 Dec 2023 07:48:18 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] platform/x86: wmi: linux/wmi.h: fix Excess kernel-doc
 description warning
To: Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc: Hans de Goede <hdegoede@redhat.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 platform-driver-x86@vger.kernel.org
References: <20231223050656.14068-1-rdunlap@infradead.org>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <20231223050656.14068-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:cj4GOHibTCEsIDb72gWem5Ea7QgC3jSoiGNeysLnZsbbSjArRMa
 hMhj25AAI7/n6/fanpq6ljv3QkaEptUPKlK1elebf7beJRq9P+8afbStjfNpaQuOifke0P+
 W1D+CCd6FJSMPGQ3sA645y4BHATtxQWjQ6JDpiPuOE+JWOra7nlYvOQ3uiglcAqz518Uvo7
 amK96Gu7xVgVDXOSVWnmQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:xeunEg4GMIY=;N+jqmMkaOhIkQa+QeLmvZOKXEJd
 2XfbFLB7sr9qBjDpHBwpQ7HNTpiqbwwFaIM6CkBLhYjMnc9lkgQtZGrMv0klkBhwN7AKORQAK
 bo/i+uwzSEA09qCceEiZ4YhxyI900iPslT3Nn+T956uwZ5Y1TSkvZYHyfIBoscarzJ6d+2uRT
 cB7Y0Czz98ugTRn1hZs7KxDO/S64ULXzlJatCHx9ksy21Dx3IKpK5/SKNCcuM9TmlumFnqpjk
 nnQRSOKcGIEeoliwkrdFgs8G5+YiHmIOVTDngTTsW148gkiQwbpIkaHIVeUbkbvI5xBa9l6XX
 m3/YMHYkMbVSjgaImUlxBFP6CTHx2XagK++OpYXf6qojG248037HQThZCp+M1qLU7hw58j2ZE
 Ua3GSoEHrbnzXz2nGj5g9Rhk3igNQBOhvcDe3eqGhoHJ3G0ly34QNyr89Sbil/zSojTvtRU5a
 k0RHeKnT7jyeG3j3KdVE/KAnTaqEuhchSdqG5acZIaohmA/R6ynavSycu9ulhcbIcFRwvVOc1
 c2j/vwXqdt0hd0xs3LUxzH6Bo9YNwCGGXycMVHsI1KBIdoPJybK726XYCvF0fryp9tkESqPzW
 dtTZXvc4jMQRPfGzuX0jzMrj0MW/9M2AFnoP4sKPRzXglarny7orQ4Cbn8Yrcy1PV3thfMZTo
 +iOsndlNTdzAfTaudAdHuyqpARWUOjTO7ySsn6PaKP1a4fWnD1Sh5naUIebWSS6x1W/zQzMbs
 cWFjwemQSMT4g5AnMQJ9DfMKJnJbzT0fkIF89nQQbJm5QAYDJkJo6vIdPAJqYgT/+X7+pXR0l
 LuiiuFlk52kShAcl4aNe/7AbhqbnVVP+8lY0BBwNCaY3GEnif4GuSw0RSMJCjYFUGl9ctQy/x
 WuP6Zcd6vWFd5fM6FWP9HYFvFvfW01BUk2GvmmOhcbYiP4iLTvt5tgMXfmqivVueJLkBQBFQf
 7M50rsnFUu31mU5ZhNKRE+q22qw=

Am 23.12.23 um 06:06 schrieb Randy Dunlap:

> Remove the "private:" comment to prevent the kernel-doc warning:
>
> include/linux/wmi.h:27: warning: Excess struct member 'setable' descript=
ion in 'wmi_device'
>
> Either a struct member is documented (via kernel-doc) or it's private,
> but not both.

Hi,

i am not encountering this kernel doc warning, but your argument is still =
valid. I also seem to
have missed the fact that WMI drivers may want to know whether their WMI d=
ata block is setable
during runtime when i added those kernel-doc comments.

Please add a Fixes: b4cc979588ee ("platform/x86: wmi: Add kernel doc comme=
nts") tag so that
this patch can reach the stable kernels. With that addressed, you may also=
 add:

Reviewed-by: Armin Wolf <W_Armin@gmx.de>

Thanks,
Armin Wolf

> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Armin Wolf <W_Armin@gmx.de>
> Cc: Hans de Goede <hdegoede@redhat.com>
> Cc: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> Cc: platform-driver-x86@vger.kernel.org
> ---
>   include/linux/wmi.h |    2 --
>   1 file changed, 2 deletions(-)
>
> diff -- a/include/linux/wmi.h b/include/linux/wmi.h
> --- a/include/linux/wmi.h
> +++ b/include/linux/wmi.h
> @@ -21,8 +21,6 @@
>    */
>   struct wmi_device {
>   	struct device dev;
> -
> -	/* private: used by the WMI driver core */
>   	bool setable;
>   };
>

