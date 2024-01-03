Return-Path: <linux-kernel+bounces-16027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B816882372E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 22:36:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5467B281A38
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 21:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0A531DA20;
	Wed,  3 Jan 2024 21:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="UwyT4oom"
X-Original-To: linux-kernel@vger.kernel.org
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E810D1D687;
	Wed,  3 Jan 2024 21:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
Received: from localhost (unknown [IPv6:2601:280:5e00:7e19::646])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 27D511C33;
	Wed,  3 Jan 2024 21:36:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 27D511C33
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1704317808; bh=Pp+S4dnT1+94l+jOINYFV0VO5dbfPFIuxTyiE3wcd/M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=UwyT4oomfbvbcT8MGD+wZGT6FriTY4R6KbSyczzQOBTXWE9swrKrKpvA3Gl1zJavp
	 23Mt7u4Kj42970Uz1uBBavRAZzTn72w+chbeRtjXgYF1H50EmI0hMj91Gxf8NjmyWw
	 Wd0tw2Rjb6gJZ2R1RxulRYFHFBgkfEz1Os8ozxjjhQ3lfogH3rPx6MIWE4snzAOJUZ
	 7ly/FjrT4IwFJgvifG+q9YpUwqIdoSGLa5jmzY7XXUl6OC8XSIgxqD6SxrOW5fFPUr
	 8t/FSj+/mT820UVjTQx86dBWCnB0AlJCg2DiDlDpwjCzB+LGGQk3ECOQigWVcdEKaM
	 uE6BzSVBv+C8A==
From: Jonathan Corbet <corbet@lwn.net>
To: Tiezhu Yang <yangtiezhu@loongson.cn>, Steven Rostedt
 <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>
Cc: linux-doc@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] docs, kprobes: Update email address of Masami
 Hiramatsu
In-Reply-To: <20231219062330.22813-2-yangtiezhu@loongson.cn>
References: <20231219062330.22813-1-yangtiezhu@loongson.cn>
 <20231219062330.22813-2-yangtiezhu@loongson.cn>
Date: Wed, 03 Jan 2024 14:36:47 -0700
Message-ID: <87mstm6qvk.fsf@meer.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Tiezhu Yang <yangtiezhu@loongson.cn> writes:

> According to the latest authorship and Signed-off-by:
>
>   Masami Hiramatsu (Google) <mhiramat@kernel.org>
>
> Masami Hiramatsu is working at Google, so the current email @redhat.com
> is out of date, it is better to use the email @kernel.org.
>
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> ---
>  Documentation/trace/kprobes.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/trace/kprobes.rst b/Documentation/trace/kprobes.rst
> index f825970a1495..968ae080accd 100644
> --- a/Documentation/trace/kprobes.rst
> +++ b/Documentation/trace/kprobes.rst
> @@ -4,7 +4,7 @@ Kernel Probes (Kprobes)
>  
>  :Author: Jim Keniston <jkenisto@us.ibm.com>
>  :Author: Prasanna S Panchamukhi <prasanna.panchamukhi@gmail.com>
> -:Author: Masami Hiramatsu <mhiramat@redhat.com>
> +:Author: Masami Hiramatsu <mhiramat@kernel.org>

Masami, is this change OK with you?

Thanks,

jon

