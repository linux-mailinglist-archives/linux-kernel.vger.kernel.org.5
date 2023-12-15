Return-Path: <linux-kernel+bounces-1243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFAB8814C3C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 17:00:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CDD72824C3
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 16:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F96A3BB2E;
	Fri, 15 Dec 2023 16:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="KVLtk1/M"
X-Original-To: linux-kernel@vger.kernel.org
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99FDF3BB25;
	Fri, 15 Dec 2023 16:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
Received: from localhost (unknown [IPv6:2601:280:5e00:7e19::646])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id DE4B72ED;
	Fri, 15 Dec 2023 16:00:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net DE4B72ED
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1702656005; bh=upxHaV1oFUKgMeun+mdP3PZ0LNp0u5W93SeOkY5xwms=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=KVLtk1/M/RquhI+/JDlI8AoU2l6tZZQ3VX12/Il2DpiQ8nE3sR4NEDCLbbGlwJWJE
	 Bo2tjrq8q3Ruk/gpaBrYVc7MLRxDTBtJtpN+uZHRvlJxqLtpoPTHxfiKswZ4Kf1G7L
	 AGz4INEQyLQCmS+JiQyd7MF0F1vWLN+gX1VW7k8vEpUg8kHiIOS+pkjTp0eDiHh9Jg
	 L2CMRJ5ZAg17blVDTcr6ZW7mULkT86S7SbYkCxo7o++dz2i9SSDcw/lzCtY4dbJeFk
	 C1IaSxnEVYox+oDNvr3RhXglFNQHDTucTL8N0AFOgc6WmlnihBqfE4K3Q2RUO42D+w
	 CjVptWWBp4fJw==
From: Jonathan Corbet <corbet@lwn.net>
To: Avadhut Naik <avadhut.naik@amd.com>
Cc: linux-doc@vger.kernel.org, carlos.bilbao@amd.com,
 linux-kernel@vger.kernel.org, avadnaik@amd.com
Subject: Re: [PATCH 0/4] Spanish translations and corrections
In-Reply-To: <20231211023730.2026204-1-avadhut.naik@amd.com>
References: <20231211023730.2026204-1-avadhut.naik@amd.com>
Date: Fri, 15 Dec 2023 09:00:04 -0700
Message-ID: <87il4zqwvv.fsf@meer.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Avadhut Naik <avadhut.naik@amd.com> writes:

> This patchset translates two documents into Spanish and also warns of or
> fixes existing inconsistencies.
>
> The first patch translates process/management-style into Spanish.
>
> The second patch translates process/submit-checklist into Spanish
>
> The third patch warns of some links in Spanish translation pointing to
> English documentation.
>
> The fourth patch moves howto.rst file into the process directory for
> Spanish translation per the original English documentation.

I've applied the series, thanks.  One little nit:

> Reviewed-By: Carlos Bilbao <carlos.bilbao@amd.com>

While there are 400 instances of Reviewed-By (capital "B") in the commit
history, they are rather overshadowed by the over 250,000 instances of
"Reviewed-by" (lower-case "b").  I think it's best to stick with the
crowd here, so I changed those tags.

Thanks,

jon

