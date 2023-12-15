Return-Path: <linux-kernel+bounces-582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0DC381433D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 09:06:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 764A41F230C4
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 08:06:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9045711190;
	Fri, 15 Dec 2023 08:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="ordYmHJ+"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 444AD18AE1;
	Fri, 15 Dec 2023 08:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from 8bytes.org (p4ffe1e67.dip0.t-ipconnect.de [79.254.30.103])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 440051A230B;
	Fri, 15 Dec 2023 09:06:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1702627570;
	bh=OkEpmCjmacYvQzkZNvnUiFvrqwjUDe3c2eZzK8vTqw4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ordYmHJ+C9oE47yNpE52tp/tNulBl8pgnO5ZePNFyTSgc+bq5vxZCMj8sANP3b0Qo
	 tYQEQQg1zGTrAwojWY5NlsITds4ZMZ/rccniMlVoxrdhyXLhaOnsZq+FIAKTMRfHfS
	 NQGP7boRyTyHae6knEWhVbQas96v4aEYbMIwrC7FQ4gnewVhNX8hbgLBOpX7xHwVLN
	 Ocs3dkQAFiq9spC0Fdnwj0JEpZTSVMkRs78vhLkvZjwgvkWY/LiDGDxRdOfSzodUPg
	 ErZay1RiAMmOYI1WARNQ4KVd+OIcntAvlxwX4hSNxaKk2e/pTOS+9USp9WL1RIfzyz
	 io8GDNlsHqDEw==
Date: Fri, 15 Dec 2023 09:06:09 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Andy Yan <andyshrk@163.com>
Cc: iommu@lists.linux.dev, heiko@sntech.de, conor+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
	robin.murphy@arm.com, will@kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	Andy Yan <andy.yan@rock-chips.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v2] dt-bindings: iommu: rockchip: Add Rockchip RK3588
Message-ID: <ZXwI8TzrvizvCC0f@8bytes.org>
References: <20231212005710.1837066-1-andyshrk@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231212005710.1837066-1-andyshrk@163.com>

On Tue, Dec 12, 2023 at 08:57:10AM +0800, Andy Yan wrote:
> Changes in v2:
> - Add maintainers for the iommu subsystem to cc list
> 
>  .../devicetree/bindings/iommu/rockchip,iommu.yaml     | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)

Applied, thanks.

