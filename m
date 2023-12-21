Return-Path: <linux-kernel+bounces-8139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B772C81B287
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 10:37:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 572CF1F24C00
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 09:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E70164C3AB;
	Thu, 21 Dec 2023 09:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ETCEdnxS"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 183CD2032E;
	Thu, 21 Dec 2023 09:32:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06289C433C8;
	Thu, 21 Dec 2023 09:32:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1703151131;
	bh=Xytoklf6LoXx81tVlVAqCYpm++U0gEaAXCzQUSkVYsE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ETCEdnxSx2wOci8gxeXZKXsMHTfUV7X6pMFSD18AO2PV9aXfBZeIbGiaw0qh8m0KM
	 9u7MayesYQ7F7vRCgBXu4TT8aSsJFltRKGhc4AgjRsYf3O578UWq5NcxvslE4srRo5
	 b2sHDh0rdfzSLOtx20BWFROgR4MFZtsZKrOHWK1c=
Date: Thu, 21 Dec 2023 10:32:09 +0100
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
Subject: Re: [PATCH net 1/2] MAINTAINERS: Remove Karsten Keil
Message-ID: <2023122156-diocese-movie-3d75@gregkh>
References: <20231221091419.11764-1-bagasdotme@gmail.com>
 <20231221091419.11764-2-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231221091419.11764-2-bagasdotme@gmail.com>

On Thu, Dec 21, 2023 at 04:14:18PM +0700, Bagas Sanjaya wrote:
> He's no longer active maintaining ISDN/mISDN subsystem: his last message
> on kernel mailing lists was three years ago [1] and last commit activity
> from him was 1e1589ad8b5cb5 ("mISDN: Support DR6 indication in mISDNipac
> driver") in 2016 when he gave Acked-by: from his @b1-systems.de address.
> 
> Move him to CREDITS, as netdev people should already handle ISDN/mISDN
> patches.
> 
> Link: https://lore.kernel.org/r/0ee243a9-9937-ad26-0684-44b18e772662@linux-pingi.de/ [1]
> Cc: Karsten Keil <isdn@linux-pingi.de>
> Cc: Karsten Keil <keil@b1-systems.de>
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>

Are you sure he's not active?  It doesn't take much work to keep an old
subsystem like this alive, last I remember, real changes were accepted
just fine.

Perhaps just don't send coding style cleanups to old subsystems?  :)

I would not take these unless Karsten agrees that he no longer wants to
maintain this.

thanks,

greg k-h

