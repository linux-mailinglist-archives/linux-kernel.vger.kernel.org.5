Return-Path: <linux-kernel+bounces-5264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AAAA8188B2
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 14:34:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 516031F22A13
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 13:34:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22FCE1945A;
	Tue, 19 Dec 2023 13:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="X947UtBL"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58A8E1944E
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 13:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from 8bytes.org (p4ffe1e67.dip0.t-ipconnect.de [79.254.30.103])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id C560A1A41B9;
	Tue, 19 Dec 2023 14:34:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1702992847;
	bh=pKeIoOVsIxB/5QJNK0ENbaC+d1It2tEeImGDEeU/FXA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X947UtBLPGIdPVN+a4LNx48qkue9hCt9o23aN5ACX9u18uXZLrhgZSY4ZA9b/YDWD
	 vaAYqkgAIT6DbfJ0V2PZi+3NkUmUO8EvhEO85BbmxshO/MFo0heBdMcI1O8BifJDJX
	 OwryiwVmqarLLw0dRxxEZxJrcBA3Fcf3Ct3EC6fvuH9B11GW+kBZPLc3t/JK+kpEge
	 12t5edszZeLzZeOzTM1jih3KRYfhleix6Ax0KQ2vxoEiVLkbsLqitKgG6I7zTfKyc/
	 mNBiJAOqs9QDP3rwNmpd5Ptfk194BoKWdLI24SEH/bE8P32Y++xzmu5Q9TzSMQ80GG
	 mvTdckTKQjKMw==
Date: Tue, 19 Dec 2023 14:34:06 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] [PULL REQUEST] Intel IOMMU updates for Linux v6.8
Message-ID: <ZYGbzt3HGfpqhjLq@8bytes.org>
References: <20231218073445.142401-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231218073445.142401-1-baolu.lu@linux.intel.com>

On Mon, Dec 18, 2023 at 03:34:41PM +0800, Lu Baolu wrote:
> Lu Baolu (4):
>   iommu/vt-d: Refactor device_to_iommu() to retrieve iommu directly
>   iommu/vt-d: Remove unused parameter of
>     intel_pasid_setup_pass_through()
>   iommu/vt-d: Remove unused vcmd interfaces
>   iommu/vt-d: Move inline helpers to header files

Applied, thanks.

