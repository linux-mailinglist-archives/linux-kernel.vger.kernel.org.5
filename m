Return-Path: <linux-kernel+bounces-8141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ACE681B291
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 10:38:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4ECA31F213D0
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 09:38:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C11294C3DD;
	Thu, 21 Dec 2023 09:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BLJzAzGQ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 059434C62E;
	Thu, 21 Dec 2023 09:33:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FD97C433C8;
	Thu, 21 Dec 2023 09:33:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1703151180;
	bh=9kXYBVe4VWyKcPg64mG3ckbqdxWdTNeCpzP3dYVryAA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BLJzAzGQRPwBe+PoloppF5S1uECFhHshoXmhM+VK32/qhheiowOVMir0LDmM6lr7z
	 wtnEQJiPxEZTU2KRGcQrbUniBw8KtTRTcBW/D3zKiq5PK0cxfAYUQ6CvSet5YktSpl
	 jMVaNdg8Sil9YxSumf3ryg1pucK0oBTEqay6YUH8=
Date: Thu, 21 Dec 2023 10:32:58 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Networking <netdev@vger.kernel.org>,
	Linux Kernel Janitors <kernel-janitors@vger.kernel.org>,
	Kees Cook <keescook@chromium.org>, Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Justin Stitt <justinstitt@google.com>,
	Kunwu Chan <chentao@kylinos.cn>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Nathan Chancellor <nathan@kernel.org>,
	"Steven Rostedt (Google)" <rostedt@goodmis.org>,
	Karsten Keil <isdn@linux-pingi.de>,
	Karsten Keil <keil@b1-systems.de>,
	YouHong Li <liyouhong@kylinos.cn>
Subject: Re: [PATCH net 0/2] ISDN/mISDN maintenanceship cleanup
Message-ID: <2023122121-yiddish-unproven-d793@gregkh>
References: <20231221091419.11764-1-bagasdotme@gmail.com>
 <ba2ac330-d977-4637-93bc-99ee953faab8@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ba2ac330-d977-4637-93bc-99ee953faab8@gmail.com>

On Thu, Dec 21, 2023 at 04:17:37PM +0700, Bagas Sanjaya wrote:
> On 12/21/23 16:14, Bagas Sanjaya wrote:
> > When I'm looking at simple typofix against ISDN subsystem [1], I find
> > out more about subsystem activity. It turns out that the subsystem
> > maintainer has been inactive since 3 years ago. And also, when I test
> > sending "Lorem ipsum" message to the subsystem mailing list, it gets
> > bounced.
> > 
> 
> Oops, sorry not adding the link.
> 
> [1]: https://lore.kernel.org/lkml/20231221024758.1317603-1-liyouhong@kylinos.cn/

I too like to ignore pointless changes like this at times.  Just because
others do, does NOT mean that the subsystem is not being maintained.

greg k-h

