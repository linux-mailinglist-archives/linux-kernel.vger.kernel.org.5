Return-Path: <linux-kernel+bounces-130415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D57E68977C2
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 20:05:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98B9128510C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 18:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BB9A153BCE;
	Wed,  3 Apr 2024 18:05:21 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 353CA1534EB;
	Wed,  3 Apr 2024 18:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712167521; cv=none; b=Zjje9a0Yjaz51nRtVPhp9Mjh1FTcff6eWM/Hy566PyzCb8jRLmGAnT6BUNZEI0jqoHS+CdA1nA7FM559p8kUpyhGszlB3EOkndLe9dyJf0XWPDNVNnRfcix+w/Ypm1j6o7a+rWSHpXiPRWp+CJcsfNWWJEUA2fnc3U2R5Og6sC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712167521; c=relaxed/simple;
	bh=BW0qGNpYxqyW9CZOIJd25JgS217Us5Xk4x7g/Nhn6hA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fvs3STnUrNXcm46po6B6FUkOFOTGSMkwz4CD5t7WwjmV9YEyKD9nQiJ+QBM7PdF0lEdZOsmlHAjlp5cfxblBlh9ZZYa1RfjP8XKihpcT5rYMLVnTEILKu5VZvVRmIZnpX2ry5/mzYhyPgXqSWo8SM5EvyLMaXnUkgW6+/Axgi2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 0F13268D08; Wed,  3 Apr 2024 20:05:13 +0200 (CEST)
Date: Wed, 3 Apr 2024 20:05:12 +0200
From: Christoph Hellwig <hch@lst.de>
To: Joseph Salisbury <joseph.salisbury@canonical.com>
Cc: hch@lst.de, linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	axboe@kernel.dk, gregkh@linuxfoundation.org, sashal@kernel.org,
	stable@vger.kernel.org,
	Francis Ginther <francis.ginther@canonical.com>
Subject: Re: [v5.15 Regression] block: rename GENHD_FL_NO_PART_SCAN to
 GENHD_FL_NO_PART
Message-ID: <20240403180512.GA3411@lst.de>
References: <924449dc-9b1f-4943-afe3-a68c03aedbb5@canonical.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <924449dc-9b1f-4943-afe3-a68c03aedbb5@canonical.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Hi Joseph.

given that Canonical ignores our kernel licensing rules and tries to
get away with it I'm not going to offer any help to Canonical at all.

