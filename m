Return-Path: <linux-kernel+bounces-9528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B708081C70E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 10:00:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CCA61F26529
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 09:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93CF3FBF2;
	Fri, 22 Dec 2023 09:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bQoDUVrf"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C04E3F9EF;
	Fri, 22 Dec 2023 09:00:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBBBCC433C7;
	Fri, 22 Dec 2023 09:00:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1703235609;
	bh=tg93fohROlHo1ujYMsFNwI1YlVMi2FqffVBy1awdsZo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bQoDUVrfbSjMhD8ypl9oeqsk7YXNoyasCjbGwLOR8Mxu6dh68hFj8AlwBA+mGz44n
	 GCoo75Z9netHPQnFHuuL0CTpQ3mEEgfM1C+K/J0R5pldDK5GCyJEns6LimuEXH3H7v
	 Ufs98/GYvH+VEphf4sxWRiJyu57qDxyqU3kHzfCE=
Date: Fri, 22 Dec 2023 10:00:06 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Johan Hovold <johan@kernel.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] USB-serial device ids for 6.7-rc6
Message-ID: <2023122259-jeep-overprice-04e9@gregkh>
References: <ZYVIEZrOWCbq63Cb@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZYVIEZrOWCbq63Cb@hovoldconsulting.com>

On Fri, Dec 22, 2023 at 09:25:53AM +0100, Johan Hovold wrote:
> The following changes since commit a39b6ac3781d46ba18193c9dbb2110f31e9bffe9:
> 
>   Linux 6.7-rc5 (2023-12-10 14:33:40 -0800)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial.git tags/usb-serial-6.7-rc6

Pulled and pushed out, thanks.

greg k-h

