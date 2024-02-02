Return-Path: <linux-kernel+bounces-50155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A36AD8474FE
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 17:37:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D63CA1C270F6
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 16:37:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2959C1487EF;
	Fri,  2 Feb 2024 16:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EBaDt9vl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AB037C6E9;
	Fri,  2 Feb 2024 16:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706891825; cv=none; b=WBORIr4/lLoIruBnDgYLc6Ys+I3n4eTJ9WsV4C7coxBxxbvof5ROGBsX6gWOBDzLEzGvD6DrUNvundDgOTLay5Zj3ekrGLuKESBfGHlyEZnBJpEedCMm8cTmniVcHiqtf/IgzgYYGwVJQcZP0Gn4gPXv9cj1d60FqmSiN494gvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706891825; c=relaxed/simple;
	bh=y5IcBKV3F2O5s8JZEQwx5DOJiy3G167IIZkbnmIdhaw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZwOm8Q2ShRHDPB94zrxCy/2Snp8cXAffEDopn8iTC8H0qF3OLqnOpTWfNys3Vcfy5Q7bU7/YlNSPeXuJCNztVdShSdrakStfskmrVPAjwL/eMLlBKVwfyWD1tnw2VXYmXk0sFhhmIc5uIApDGjrN6tkC0kddLlSX+PvreesCjqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EBaDt9vl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA80AC43390;
	Fri,  2 Feb 2024 16:37:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706891824;
	bh=y5IcBKV3F2O5s8JZEQwx5DOJiy3G167IIZkbnmIdhaw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EBaDt9vlo0iqO0WlolIbLiao21t1V9ryK9CQjGjHxgyyPT6+T+FBvWKHXZNt27xjv
	 05EIJCW4QaBJWwoRq//G4Zt0lAlHoSjXAryMPhmoECXb0C3Cmbs8wZ9CrpiTPqxr96
	 WsspvOBdk/NBaWJSIvukEDvPL3ic/3vc50/WdUcU=
Date: Fri, 2 Feb 2024 08:37:04 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Johan Hovold <johan@kernel.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] USB-serial device ids for 6.8-rc3
Message-ID: <2024020255-reproach-comfort-61f8@gregkh>
References: <Zb0Hz0dFStw_bcrh@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zb0Hz0dFStw_bcrh@hovoldconsulting.com>

On Fri, Feb 02, 2024 at 04:18:39PM +0100, Johan Hovold wrote:
> The following changes since commit 6613476e225e090cc9aad49be7fa504e290dd33d:
> 
>   Linux 6.8-rc1 (2024-01-21 14:11:32 -0800)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial.git tags/usb-serial-6.8-rc3

Pulled and pushed out, thanks.

greg k-h

