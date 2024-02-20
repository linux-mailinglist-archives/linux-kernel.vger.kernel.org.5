Return-Path: <linux-kernel+bounces-72507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A00685B46D
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 09:05:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A1491C20D8B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 08:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C40915C60A;
	Tue, 20 Feb 2024 08:04:59 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5754457313;
	Tue, 20 Feb 2024 08:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708416299; cv=none; b=cr7RdjCZGSXDiilOIUT/kMyAYOkVrP8g/gCBwLRJn6R9ZrT0zvr73YszgOo4dtx67LnOc3e5hm4tXL7iSEx4klaqqtTUjtPo48WrVAnK72YkT2G+1uXJzxdCOraLi5AUwpLJarA/tbjC12rBEWw/b0jC/0fb6w8bOKuxneYUB1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708416299; c=relaxed/simple;
	bh=DVqDi+AqC9bkEFpK+hyX5MWeJzw1Rz4Jx2k6xRZByDw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UfWkdKXjDjXuub6T4A0WXWjbnBqalEjUmX9n/myFKmbrxHXKuFeflo+f+uM7FG77vevaEpDsK4wNP8qKqJvGnCnrUSIXCZu1ozd0ButE3PgbNt0Ao1gXNdZVe9k7EgZaBBNkkPW8hHcZPR9dpDxn8Ci3+OXcn9vIWro8XgjUE30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 298E267373; Tue, 20 Feb 2024 09:04:49 +0100 (CET)
Date: Tue, 20 Feb 2024 09:04:48 +0100
From: Christoph Hellwig <hch@lst.de>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Linus Walleij <linus.walleij@linaro.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the mmc tree with the block tree
Message-ID: <20240220080448.GA12310@lst.de>
References: <20240220120117.15188a66@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240220120117.15188a66@canb.auug.org.au>
User-Agent: Mutt/1.5.17 (2007-11-01)

Thanks, the merge looks good to me.

