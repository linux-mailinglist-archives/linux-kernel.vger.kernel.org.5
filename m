Return-Path: <linux-kernel+bounces-16216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F331A823AE7
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 03:59:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F390D287F9A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 02:59:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63A3F5231;
	Thu,  4 Jan 2024 02:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XAvW7t9+"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C15C4C83;
	Thu,  4 Jan 2024 02:58:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DDE3C433C8;
	Thu,  4 Jan 2024 02:58:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704337138;
	bh=01K1xit/4AEQ8i0BRSYPXXAVVlLb6B3z2QascNWt8Go=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XAvW7t9+ME532xnff0Cv4Ov9JDzr39BvFUOMveX1TewOFfaXs/Tn3zF9sfBn3pm2k
	 wUeDbjA0DK1IY61bc7tHsvl7TXpDJ/7t33Jr9DuXJy/w8VTSv4iegGrCvn75hY4gGf
	 l3JFNsn95NGvxaBRpAmV3GnEKmv8n0I6eZ93KDmzrlrxybTvUw7hgT0UdvE+MF0w5a
	 3yJ5jwUibI9fptvRgdyZBiFC5zdbrWu0zrUnhiQ+YSgIPByX/6HWQBAu+dJjCcBPqt
	 DS7sFGZTVHR/fL2n+O4OdnARNT70k8vzh7G5y3t+94j6gq5AsgmvWNKQZk2BkpUhhe
	 96WDbjIo0Sl+w==
Date: Thu, 4 Jan 2024 11:58:54 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Tiezhu Yang <yangtiezhu@loongson.cn>, Steven Rostedt
 <rostedt@goodmis.org>, linux-doc@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, loongarch@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] docs, kprobes: Update email address of Masami
 Hiramatsu
Message-Id: <20240104115854.e98f0081f771d4aa73647c3b@kernel.org>
In-Reply-To: <87mstm6qvk.fsf@meer.lwn.net>
References: <20231219062330.22813-1-yangtiezhu@loongson.cn>
	<20231219062330.22813-2-yangtiezhu@loongson.cn>
	<87mstm6qvk.fsf@meer.lwn.net>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 03 Jan 2024 14:36:47 -0700
Jonathan Corbet <corbet@lwn.net> wrote:

> Tiezhu Yang <yangtiezhu@loongson.cn> writes:
> 
> > According to the latest authorship and Signed-off-by:
> >
> >   Masami Hiramatsu (Google) <mhiramat@kernel.org>
> >
> > Masami Hiramatsu is working at Google, so the current email @redhat.com
> > is out of date, it is better to use the email @kernel.org.
> >
> > Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> > ---
> >  Documentation/trace/kprobes.rst | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/Documentation/trace/kprobes.rst b/Documentation/trace/kprobes.rst
> > index f825970a1495..968ae080accd 100644
> > --- a/Documentation/trace/kprobes.rst
> > +++ b/Documentation/trace/kprobes.rst
> > @@ -4,7 +4,7 @@ Kernel Probes (Kprobes)
> >  
> >  :Author: Jim Keniston <jkenisto@us.ibm.com>
> >  :Author: Prasanna S Panchamukhi <prasanna.panchamukhi@gmail.com>
> > -:Author: Masami Hiramatsu <mhiramat@redhat.com>
> > +:Author: Masami Hiramatsu <mhiramat@kernel.org>
> 
> Masami, is this change OK with you?

I would like to know the policy. Should we update the author's mail
address in the document (source) everytime?

Anyway, I'm OK for this update.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks,

> 
> Thanks,
> 
> jon


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

