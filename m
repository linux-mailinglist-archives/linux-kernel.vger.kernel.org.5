Return-Path: <linux-kernel+bounces-10292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 15A1B81D249
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 06:00:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD465B219AC
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 05:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E97B88C1A;
	Sat, 23 Dec 2023 05:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pePV5y5+"
X-Original-To: linux-kernel@vger.kernel.org
Received: from out-175.mta0.migadu.com (out-175.mta0.migadu.com [91.218.175.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BB2D6FD7
	for <linux-kernel@vger.kernel.org>; Sat, 23 Dec 2023 05:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sat, 23 Dec 2023 00:00:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1703307635;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nHi2s1ywhHyj2ikLzCZWLKuKjtJbPgi5kAvkTiqjfVk=;
	b=pePV5y5+NpL7hzm8DfIAqLqHLKbxFtmxbSoMLO8EfHJP15sUi5pst1+SnlACvXp8cujFJO
	2lICnakFS267jhMyqNSwv4mGNVDgjxrn1sPP/wPsygbCOg6qJAIFHtevYfJXKP9ijbhEUu
	IhxZjA4oc8Sf64TOz/oye6tdLouYRAU=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc: ntfs3@lists.linux.dev, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/8] fs/ntfs3: Bugfix and refactoring
Message-ID: <t6cy5hu6cxsnawvlxsl4xlcqskkq2njeapjpwy4eku2kchgnue@w4cura2wu4pn>
References: <e41f6717-7c70-edf2-2d3a-8034840d14c5@paragon-software.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e41f6717-7c70-edf2-2d3a-8034840d14c5@paragon-software.com>
X-Migadu-Flow: FLOW_OUT

On Mon, Jul 03, 2023 at 11:23:49AM +0400, Konstantin Komarov wrote:
> This series contains various fixes and refactoring for ntfs3.
> Added more checks in record.

I don't write explanations for all of my commits, but... zero?

