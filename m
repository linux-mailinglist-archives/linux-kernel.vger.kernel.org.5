Return-Path: <linux-kernel+bounces-14053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 54C6582176A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 06:35:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 01985B21363
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 05:35:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F404137D;
	Tue,  2 Jan 2024 05:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JskhMJ7U"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 784AE10FD
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jan 2024 05:35:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E33CC433C8;
	Tue,  2 Jan 2024 05:35:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1704173730;
	bh=SX9Gk1b+MBMeaXcODyUMTEH6UHBVU/TYWtv4yEUxA/s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JskhMJ7UcjTjF5OwP0mzsiBN7yIEK6PdP8TBLnCMVuCNREvzK0JC8ovAeUoe++Pmx
	 4GIP1qP1vaYD41s7x6LCyWWeqsbSbV4Onky1u0LVfBE2jsrWl+pgZ6w6i/CyX+KPK1
	 yAfrwxuJDfnQF5Tk/YZp0Q7I1ouMNfenaz7VmZpg=
Date: Tue, 2 Jan 2024 00:35:29 -0500
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: Valerio Vanni <valerio.vanni@inwind.it>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Unable to unsubscribe
Message-ID: <20240102-laughing-tacky-bettong-d63ab6@lemur>
References: <d90fd289-0535-c4ab-8dc0-5e0fb0a36a72@inwind.it>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d90fd289-0535-c4ab-8dc0-5e0fb0a36a72@inwind.it>

On Mon, Jan 01, 2024 at 11:09:48PM +0100, Valerio Vanni wrote:
> Some time I subscribed to linux-kernel list, but now I want to unsubscribe.
> 
> I read here
> https://subspace.kernel.org/vger.kernel.org.html#what-happened-to-majordomo
> that to subscribe and unsubscribe a list I have to use the address provided.
> 
> For linux-kernel I find:
> linux-kernel+unsubscribe@vger.kernel.org
> 
> I wrote two o three times, but nothing happens. I don't get any error oro
> bounce messages. Simply, it doesn't work: I continue to receive messages.

I see your unsubscription requests and I can see that we send a confirmation
message to you. Can you please check all of your folders? The subject is
"Confirm unsubscribe from linux-kernel@vger.kernel.org".

> I wrote also to postmaster@vger.kernel.org, but got no answer.

It's holidays. :)

-K

