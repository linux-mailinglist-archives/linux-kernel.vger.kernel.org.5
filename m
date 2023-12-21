Return-Path: <linux-kernel+bounces-7751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 242CE81AC9D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 03:29:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 511451C237E1
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 02:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C42931FCF;
	Thu, 21 Dec 2023 02:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QC32akgA"
X-Original-To: linux-kernel@vger.kernel.org
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D79371864
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 02:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1703125770;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a82gGQRn2klzFFH08VrOJazEoKIYu7QwaCXD4vn97sk=;
	b=QC32akgAtVB+QyyTcoA4XKgRllEHMAJ/WJFQipnuwTYAc347yCrL5fKQO2E8p8rDJkunO+
	yNxtiP5s4mahF5Rqey6zhDXPU49okf7BqWQmAp895m0/UatLSkk7Tw0FcFhiba56p3NTkx
	oU3ioOozAqg/sljwxV/xpBf/EjVD308=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Subject: Re: [PATCH] MAINTAINERS: remove hugetlb maintainer Mike Kravetz
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20231220220843.73586-1-mike.kravetz@oracle.com>
Date: Thu, 21 Dec 2023 10:28:52 +0800
Cc: Linux-MM <linux-mm@kvack.org>,
 LKML <linux-kernel@vger.kernel.org>,
 Muchun Song <songmuchun@bytedance.com>,
 Andrew Morton <akpm@linux-foundation.org>
Content-Transfer-Encoding: 7bit
Message-Id: <7FDBF7BA-C49F-4524-BD8F-2BC8B171941F@linux.dev>
References: <20231220220843.73586-1-mike.kravetz@oracle.com>
To: Mike Kravetz <mike.kravetz@oracle.com>
X-Migadu-Flow: FLOW_OUT



> On Dec 21, 2023, at 06:08, Mike Kravetz <mike.kravetz@oracle.com> wrote:
> 
> I am stepping away from my role as hugetlb maintainer.  There should be
> no gap in coverage as Muchun Song is also a hugetlb maintainer.
> 
> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>

Thanks for your work, Mike.


