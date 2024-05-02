Return-Path: <linux-kernel+bounces-166469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB5CC8B9B1A
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 14:49:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60F092826E0
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 12:49:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A02D882498;
	Thu,  2 May 2024 12:49:33 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9D3B6A8AC;
	Thu,  2 May 2024 12:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714654173; cv=none; b=OomlHXMrIA/7azmZN5/VENuvsCzSfh2ACST/UnVpVoMXccbtKm2sH96fwzB0qWlaNjpKdU/6k0ttdpBg6uG/3USSdlkVaFBlyYkULfCcBV0UCvZGKodCFhFEIyxGctDLu5B801vIjQRGTm5/5o5cVwE2Ng6BlCcYLEjH4u9Ea3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714654173; c=relaxed/simple;
	bh=1Iwp34WIXn/TPRJOcu6SUvQdBFGuAro05DI9cIwDPXU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OSckw7apgluaO/6jHWuP5oGJn6s8Er0a998BcCvu2gCy5Mu88PvpDJ/xrY+6Yz1NSTFOF3JC884OYyFFIXYAqNBXEJe2ovS+lIPwDJNLGVm5IO/m/32HoZ7MqwGwrYmu9A0su7cbrfJdX8d8r8ZA5aPuY+gSHQo4le+xo4f9ua0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id BD34E227A87; Thu,  2 May 2024 14:49:27 +0200 (CEST)
Date: Thu, 2 May 2024 14:49:27 +0200
From: Christoph Hellwig <hch@lst.de>
To: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, mhklinux@outlook.com,
	robin.murphy@arm.com, joro@8bytes.org, will@kernel.org,
	m.szyprowski@samsung.com, corbet@lwn.net, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	petr@tesarici.cz, roberto.sassu@huaweicloud.com
Subject: Re: [PATCH v4 1/1] Documentation/core-api: Add swiotlb
 documentation
Message-ID: <20240502124927.GA20542@lst.de>
References: <20240501151651.2912-1-mhklinux@outlook.com> <20240502055205.GA28436@lst.de> <ZjNjE2KyLxdT0HSR@archie.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZjNjE2KyLxdT0HSR@archie.me>
User-Agent: Mutt/1.5.17 (2007-11-01)

Fixed.

