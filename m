Return-Path: <linux-kernel+bounces-26503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 13B7B82E234
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 22:27:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 212261C22278
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 21:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 692871B275;
	Mon, 15 Jan 2024 21:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="XEci/Gxz"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D24E1AADF
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 21:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1705353638;
	bh=8Q8IQ6nfy2xImHyVMHWYDExGtASfHOX7tOIjTf2bzGU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XEci/GxzsM1/vKyCQstZP1T7sI/zvs/sf1jbK1v+5XejeTyfBYd0OlutNwHJN/+Bn
	 KGvV07n4osjMc8fyMHWKZTB8Uq/wx6s69X4IybYFllUUKALgQgjZW0rBlR608IeMA1
	 ymBOSY/X1lnAge1rSKQl1AC9xZjMKK8VM8D0syI4=
Date: Mon, 15 Jan 2024 22:20:37 +0100
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Joel Granados <j.granados@samsung.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: Re: [PATCH v2] scripts: check-sysctl-docs: adapt to new API
Message-ID: <3fd9a074-88cf-45eb-9f04-f8de7314b0a7@t-8ch.de>
References: <CGME20231226113448eucas1p2790755bc45518304822dc9b24c93c2a3@eucas1p2.samsung.com>
 <20231226-sysctl-check-v2-1-2d4f50b30d34@weissschuh.net>
 <20240115154907.ubr4admknmousjbz@localhost>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240115154907.ubr4admknmousjbz@localhost>

Hey Joel,

On 2024-01-15 16:49:07+0100, Joel Granados wrote:
> Hey Thomas
> 
> I lost track of the thread here. Did you get my latest answer to your V1?
> https://lore.kernel.org/all/20231231143455.tvwb464awfzv5uti@localhost/

I got your last anwer.

Unfortunately I didn't find much time to work on my sysctl patches
recently. It should improve in the near future, though.

Thomas

