Return-Path: <linux-kernel+bounces-1137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B20F814AFE
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 15:52:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6389EB21301
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 14:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B55AC3589B;
	Fri, 15 Dec 2023 14:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1tGea66f"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D3E3364B9
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 14:52:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33FA2C433C7;
	Fri, 15 Dec 2023 14:52:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702651961;
	bh=vHZklL6okNgaouzX7lPqoPMvbQRMq0t+B2AwKC1F73k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=1tGea66f9N9gDTQuSAM/oroaVBduEABypllN8dFOZdUR9P3LWky07O9TurYe7ySy7
	 wf6rVqoT17nLTbchjjsm6hU2rMOonw6IIFkU4/XauPPYhI8kwgRcJGmv9vgiJk6nPh
	 qtotxR+kdwFICG/2luRiYs0PmTRl4RHPPkCjZJKI=
Date: Fri, 15 Dec 2023 15:52:39 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: =?iso-8859-1?Q?Ren=E9?= Nyffenegger <mail@renenyffenegger.ch>
Cc: cristian.ciocaltea@gmail.com, masahiroy@kernel.org, cmllamas@google.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Update comment (addition of gtags) in scripts/tags.sh
Message-ID: <2023121528-frightful-showman-993b@gregkh>
References: <20231215134246.6352-1-mail@renenyffenegger.ch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231215134246.6352-1-mail@renenyffenegger.ch>

On Fri, Dec 15, 2023 at 02:42:46PM +0100, René Nyffenegger wrote:
> Commit f4ed1009fc (kbuild: add GNU GLOBAL tags generation) added support
> for the GNU Global source tagging system. However, this addition
> was not reflected in the script's header comment.
> 
> Signed-off-by: René Nyffenegger <mail@renenyffenegger.ch>

So this needs a "Fixes:" tag, right?

thanks,

greg k-h

