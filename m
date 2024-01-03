Return-Path: <linux-kernel+bounces-16024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCFDD823725
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 22:34:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC03E1C2488D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 21:34:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B96C21D6B8;
	Wed,  3 Jan 2024 21:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="LJCLgv9z"
X-Original-To: linux-kernel@vger.kernel.org
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECEC91D687;
	Wed,  3 Jan 2024 21:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
Received: from localhost (unknown [IPv6:2601:280:5e00:7e19::646])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 0049A8E3;
	Wed,  3 Jan 2024 21:34:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 0049A8E3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1704317662; bh=r4lpFrTdY5NQA/tWluRONgdtTT+sQFjhp4ggRHBRa7s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=LJCLgv9zJ9OqoEEDmzYYBLH71jM3uc0inH+HJtf9JUBYCMFNHsd0MDvHQk8uGDkLY
	 Pke5g20OTI0sjabBIrwRNBjJzR9+uf9ynriUsAZdsgHaltECagBL3ggyGX+8hfloP/
	 Vb5HBGmtXZLEn2/MTJmgLREtS+XPuAADjL86uoq+TjZgHR/3GjYPRMPws9/J89rkRw
	 LbvmAc7uytPQnCgc48NKCBsnrE6P4OuRo6hCzM81qULCuixsaJhPUh85lEFted32kg
	 XfoFda9cza2H6nuhLujLcy0D/SuXfnKMy1apOJnA+HDdt7BXUn9YXpeO6QJmQSvwdt
	 NbNCNBTt7UNgQ==
From: Jonathan Corbet <corbet@lwn.net>
To: Yanteng Si <siyanteng@loongson.cn>, longjin <longjin@dragonos.org>,
 alexs@kernel.org
Cc: linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] Translated the RISC-V architecture boot documentation.
In-Reply-To: <9ecb2a82-2eca-4909-9c33-00ee8b13b804@loongson.cn>
References: <20231218092924.200165-1-longjin@DragonOS.org>
 <9ecb2a82-2eca-4909-9c33-00ee8b13b804@loongson.cn>
Date: Wed, 03 Jan 2024 14:34:21 -0700
Message-ID: <87v88a6qzm.fsf@meer.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Yanteng Si <siyanteng@loongson.cn> writes:

> =E5=9C=A8 2023/12/18 17:29, longjin =E5=86=99=E9=81=93:
>> The patch adds a new file boot.rst to the Documentation/translations/zh_=
CN/
>> arch/riscv/ directory, and adds a reference to the new file
>> in the index.rst file.
>>
>> Signed-off-by: longjin <longjin@DragonOS.org>
>
> Reviewed-by: Yanteng Si <siyanteng@loongson.cn>

I've applied this, thanks.  In the future, please copy me directly on
documentation patches.

jon

