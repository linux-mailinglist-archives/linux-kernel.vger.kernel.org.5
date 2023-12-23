Return-Path: <linux-kernel+bounces-10411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C76E681D412
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 13:50:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0623E1C21059
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 12:50:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CD97D2F2;
	Sat, 23 Dec 2023 12:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oIulUe6I"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9F31D28A;
	Sat, 23 Dec 2023 12:50:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA083C433C8;
	Sat, 23 Dec 2023 12:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1703335804;
	bh=2CbZuZ2v3eiSej/7rXXmoK+0Ik4VfWBc0bkN4BKn7dk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oIulUe6IXF4hlKZrp+4N5IZOYhXw4ADXeuh9DtdvqygsFj/AsLlUvUgmJmcH0q+QZ
	 Vx7ENUjNTga2fME96batpjFlmALUAedjoWW+mIZMMkIW2EWN1ChyH1DEaZ6m65FcTy
	 PKV+DxmmtV7ohKgJ30qLs+aqjB+ruyutWqvOzohU=
Date: Sat, 23 Dec 2023 13:49:30 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Georgi Djakov <djakov@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] interconnect changes for 6.8
Message-ID: <2023122348-clubhouse-roundness-c38d@gregkh>
References: <20231222105649.1607990-1-djakov@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231222105649.1607990-1-djakov@kernel.org>

On Fri, Dec 22, 2023 at 12:56:49PM +0200, Georgi Djakov wrote:
> Hello Greg,
> 
> This is the pull request with interconnect changes for the v6.8-rc1 merge
> window. It contains some new drivers. As always, the summary is in the
> signed tag.
> 
> All patches have been in linux-next for more than a week. Please pull into
> char-misc-next when possible.
> 
> Thanks,
> Georgi
> 
> The following changes since commit b85ea95d086471afb4ad062012a4d73cd328fa86:
> 
>   Linux 6.7-rc1 (2023-11-12 16:19:07 -0800)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/djakov/icc.git tags/icc-6.8-rc1

Pulled and pushed out, thanks.

greg k-h

