Return-Path: <linux-kernel+bounces-2130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F02D5815839
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 08:27:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 432C6287F38
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 07:27:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37B6C134D6;
	Sat, 16 Dec 2023 07:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hujMHBDn"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 769506FAA;
	Sat, 16 Dec 2023 07:27:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9130EC433C7;
	Sat, 16 Dec 2023 07:27:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702711626;
	bh=AxBGOb0MEIuvPHIzTtlEflFbxB5vtRPk+pKiTQyH4xs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hujMHBDnyiDGUkMyOYALIWB+8QmHpMTknRsYBOYes865/36d1AXMDj32Y9tuXL7t9
	 uPuTsQyaFzmEB5jFr1eoVQpKQl7qCaVFqMiWThi1g/dhW5wlf3idhPG4yMKBlE3p0W
	 NDykxmsHcVv3tYTS9k33gUVcTDrfhkfTiTo3yeeQ=
Date: Sat, 16 Dec 2023 08:27:03 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Gary Rookard <garyrookard@fastmail.org>
Cc: philipp.g.hortmann@gmail.com, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/4] [Series 4] staging: rtl8192e: rename variable pHT
 and (3) other
Message-ID: <2023121627-armless-value-6fd7@gregkh>
References: <20231216010105.9810-1-garyrookard@fastmail.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231216010105.9810-1-garyrookard@fastmail.org>

On Fri, Dec 15, 2023 at 08:01:01PM -0500, Gary Rookard wrote:
> Hi,
> 
> This patch series renames (4) different variables with
> the checkpatch coding style issue, Avoid CamelCase.
> 
> (resubmittals)

I see two different copies of this patch set, please send only one as
now I don't know which one is "real".

Please fix up and send a v3, I've dropped both from my queue.

thanks,

greg k-h

