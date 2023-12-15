Return-Path: <linux-kernel+bounces-424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C17A8140F9
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 05:33:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B863FB22434
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 04:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 162FD79ED;
	Fri, 15 Dec 2023 04:33:16 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB7D5882D;
	Fri, 15 Dec 2023 04:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id A243168AFE; Fri, 15 Dec 2023 05:33:10 +0100 (CET)
Date: Fri, 15 Dec 2023 05:33:10 +0100
From: Christoph Hellwig <hch@lst.de>
To: Song Liu <song@kernel.org>
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>, Neil Brown <neilb@suse.de>,
	Guoqing Jiang <guoqing.jiang@linux.dev>,
	Mateusz Grzonka <mateusz.grzonka@intel.com>,
	Jes Sorensen <jes@trained-monkey.org>
Subject: Re: [PATCH 2/3] md: Remove deprecated CONFIG_MD_MULTIPATH
Message-ID: <20231215043310.GB15593@lst.de>
References: <20231214222107.2016042-1-song@kernel.org> <20231214222107.2016042-3-song@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231214222107.2016042-3-song@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

