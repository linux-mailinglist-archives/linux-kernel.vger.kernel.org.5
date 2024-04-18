Return-Path: <linux-kernel+bounces-149547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 77B778A92B2
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 07:57:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4274B222C8
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 05:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E6395FB97;
	Thu, 18 Apr 2024 05:57:15 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69DA255E58;
	Thu, 18 Apr 2024 05:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713419834; cv=none; b=VscfR6ohdQkeBIglqZADtIuDbTk5zE/SiNFX3QVTnAnKAcdRADgP7EsXBu/QQU9YnviYFW4VjCQXtX98/WJPKHKE5okk50x17dlrNVwDDRXVssSkEvT5xMQyVhXcLHzgMi4XSrHPdKSahMDiDru/HPujmDvuZFKSsLJhXCEJPoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713419834; c=relaxed/simple;
	bh=EPkI3/Lfd4nekT9M7/fU7oixclKwgHuskeDBcm0iNJA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XGaAkJDryMUsXvQtxMCoydGa/5iAGmcjto9r8+6TuXURunRorsh0hWrdFFjEf60Gn9d7uLwHEJvFp2QMssl9D4nuZ7iX0sNGsBj3KZab/fHl9mnbcGsMLz4yNJoe7PZEJ41nAw6rmK7FKmS2rSPh6fIxemEiIPDTd4e8/MmgWBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id ECD7E68C4E; Thu, 18 Apr 2024 07:57:07 +0200 (CEST)
Date: Thu, 18 Apr 2024 07:57:07 +0200
From: Christoph Hellwig <hch@lst.de>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>,
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Damien Le Moal <dlemoal@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the scsi-mkp tree with the block
 tree
Message-ID: <20240418055707.GA24656@lst.de>
References: <20240418145554.7a93325b@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240418145554.7a93325b@canb.auug.org.au>
User-Agent: Mutt/1.5.17 (2007-11-01)

Thanks Stephen,

the conflict resolution looks good to me.


