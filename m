Return-Path: <linux-kernel+bounces-151552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1723B8AB069
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 16:11:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48DCD1C22FA5
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 14:11:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C182012F581;
	Fri, 19 Apr 2024 14:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="luEKnboB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CB7D12F378;
	Fri, 19 Apr 2024 14:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713535748; cv=none; b=S16QSlM3YYhQWXv1w/XEPgg5oewfyoC71hTxRwUb020p+cfoqOS7jrbqsE00UrClRHxdtl/tesW8CDRNtlYZkCxCwCOJDMu5lN0hJ2yX9qnNUssc6GkMQI+S/o12WnZrFPd0pr30+QFpmpGQZaZh590xL3sb/V3V2jbRcrBJ1KI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713535748; c=relaxed/simple;
	bh=6YWug6x68M7BXf4/XhfVGoo3jB2nXv8G8RXC3Jxp9tQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KLN8ToybjYef9wafBP5uLTc8AsPEf3SKQZ6jkfFWQzgaIcKwPOcsKy+/5QHgLCCHVozub4RxyLELwL/BIShSYY8VipzZ1SgYrkJBryWRGuCmKup20A7kHvBKfdpIG9qanVk/JBMRqXCVmVWw4o62gqQnu+FFbcEOTz0EZ2upeak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=luEKnboB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26883C072AA;
	Fri, 19 Apr 2024 14:09:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713535747;
	bh=6YWug6x68M7BXf4/XhfVGoo3jB2nXv8G8RXC3Jxp9tQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=luEKnboB3pTvnk50W92xC7uq9rgMb3NCHfuYsnN7+3ooilMX6aLGJCoIthfyfY+Vr
	 613xx+fltQtZycPVsvLNzmd5mgatxNnwWV/HKbonqbJwPrKJBfcuyP7fJ7GC4ZMkSE
	 5IQ0JLKW+7at2FffSFpJYm8rWV6i3F9ZqTdzd7TQ=
Date: Fri, 19 Apr 2024 16:09:02 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Johan Hovold <johan@kernel.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] USB-serial device ids for 6.9-rc5
Message-ID: <2024041954-antelope-postal-d515@gregkh>
References: <ZiJlewYVQiSSSrJ6@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZiJlewYVQiSSSrJ6@hovoldconsulting.com>

On Fri, Apr 19, 2024 at 02:37:15PM +0200, Johan Hovold wrote:
> The following changes since commit 39cd87c4eb2b893354f3b850f916353f2658ae6f:
> 
>   Linux 6.9-rc2 (2024-03-31 14:32:39 -0700)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial.git tags/usb-serial-6.9-rc5

Pulled and pushed out, thanks.

greg k-h

