Return-Path: <linux-kernel+bounces-5983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BC2281927E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 22:46:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D02E3B2482D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 21:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01AD93B783;
	Tue, 19 Dec 2023 21:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="MiDTAfma"
X-Original-To: linux-kernel@vger.kernel.org
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE4823B1A4;
	Tue, 19 Dec 2023 21:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
Received: from localhost (unknown [IPv6:2601:280:5e00:7e19::646])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id E49702E5;
	Tue, 19 Dec 2023 21:46:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net E49702E5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1703022402; bh=6HnsaTuIk+hzTcM303ONrmo7fGoh+tz+JkYl9KDLHw8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=MiDTAfmaifSMeVDC2DCTp2uJk/fnUPAzQuJaWYjIpJ/Qr4duLOSEeZCenwGoe00WX
	 9ccFf8j7K6l48M376EjseAMx3/pv+l25Lq1LBviM1xnnWVNPjo9xaSJTkMNvznstzf
	 amvuhAgptduFbwk+sn85n3veI4aAD11F0ECh7Ylq/Q86YnMMoLX4JYX8QguB67qoJb
	 gVtuyo0vvt052hb75IWF68V4BdKROpRc7qaSfjUwtqFfLEaDZKJcRoQpFljWWb89Mo
	 RUrDxGN0CdoLKIO1pgy1Aw+ovxM9dd3S63/DENJmKeqYTt53rsYa2KLWE3Gf7wO7t7
	 sdKH0rxy9A1/g==
From: Jonathan Corbet <corbet@lwn.net>
To: Vegard Nossum <vegard.nossum@oracle.com>
Cc: linux-doc@vger.kernel.org, Carlos Bilbao <carlos.bilbao@amd.com>, Alex
 Shi <alexs@kernel.org>, Hu Haowen <src.res.211@gmail.com>,
 linux-kernel@vger.kernel.org, Vegard Nossum <vegard.nossum@oracle.com>,
 Federico Vaga <federico.vaga@vaga.pv.it>, Jani Nikula
 <jani.nikula@linux.intel.com>, Akira Yokosawa <akiyks@gmail.com>, Yanteng
 Si <siyanteng@loongson.cn>
Subject: Re: [PATCH v2] docs: translations: add translations links when they
 exist
In-Reply-To: <20231215123701.2712807-1-vegard.nossum@oracle.com>
References: <20231215123701.2712807-1-vegard.nossum@oracle.com>
Date: Tue, 19 Dec 2023 14:46:41 -0700
Message-ID: <87le9phnlq.fsf@meer.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Vegard Nossum <vegard.nossum@oracle.com> writes:

> Add a new Sphinx extension that knows about the translations of kernel
> documentation and can insert links to the translations at the top of
> the document.

OK, this seems pretty nice; I've applied it.

Thanks,

jon

