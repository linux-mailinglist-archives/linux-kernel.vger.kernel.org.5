Return-Path: <linux-kernel+bounces-136266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D08189D21D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 08:08:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4E2928357A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 06:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 086986E5EF;
	Tue,  9 Apr 2024 06:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicklyemailsend12.com header.i=@quicklyemailsend12.com header.b="Jg1bTiik"
Received: from quicklyemailsend12.com (quicklyemailsend12.com [164.132.59.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B6006A00B
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 06:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=164.132.59.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712642911; cv=none; b=TXZvouDR4oj59yZ3XYEOmzdv3hcwkgh1a5/Ho3sQHL/EBJjkGwiUH4BqcbusljP8G/Ik+/PpguwtE+nCCbTMwNUIqrniv1YSmqZVxFHibVqi7Mel7ktIeNmHgevjuZSNKCjXQ6ILxTrzA42id7AKgvfzTvZnpTTX/J4fbLwIcTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712642911; c=relaxed/simple;
	bh=UYR4B9ECg1XwPEWjcb0afoPgRCZ0daWWrUm8ZxuVfRA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=N1THAO+ntr9stzRN9ITIOhY8/UvONd4D4ZtwszVGpQbufVZO4TfNz0Hef0VhRkQasFKj4d7JwmLoeZCdksN4GaI0+5lVeQ5SpKRLoTXi/rSP7co4k/lgo1jxOAXLaWrE898TRgmoCvVe5vwSUteTnwo5SxuKmBd/hh6gcguESxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicklyemailsend12.com; spf=pass smtp.mailfrom=quicklyemailsend12.com; dkim=pass (2048-bit key) header.d=quicklyemailsend12.com header.i=@quicklyemailsend12.com header.b=Jg1bTiik; arc=none smtp.client-ip=164.132.59.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicklyemailsend12.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicklyemailsend12.com
Received: from quicklyemailsend12.com (unknown [103.96.83.38])
	by quicklyemailsend12.com (Postfix) with ESMTPSA id E77207F7DE
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 06:01:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 quicklyemailsend12.com E77207F7DE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=quicklyemailsend12.com; s=default; t=1712642514;
	bh=UYR4B9ECg1XwPEWjcb0afoPgRCZ0daWWrUm8ZxuVfRA=;
	h=Reply-To:From:To:Subject:Date:From;
	b=Jg1bTiiklXy3Wkj4C+E1e9o9npzEClJUMt3Xq/3PvUCZS4uIE0UQKy29hjgc3FPfA
	 KRpjQuGQsCv2w6pNTkvGyDO+644wmzWh0hakpkGGCRmTXtgPevEFXq6RslGCJT/TM6
	 olyWpmX3DwDs8ubhVwPX3xdpuwSV85PlFWv7RWhaUkZivHtvNH36rq+rNeDZDqm8wI
	 vD83d+5sLZ04osRRplRYPrBMxDKR+4BKcfpyMB0UHDPSeSa0myjPXDRUlqPaxT5qK6
	 AQljDi77UfAwg6enjzkQmN8S0Bmwi/wZPTmWAxvxP30/v92l7jmK00dtvHLWPgXFRJ
	 kawPUhMiBuBxw==
Reply-To: stern.arnlund@gogreenwalter-se.com
From: sale@quicklyemailsend12.com
To: linux-kernel@vger.kernel.org
Subject: New inquiry from sweden
Date: 09 Apr 2024 16:01:53 +1000
Message-ID: <20240409160153.98986BD4AB6DB273@quicklyemailsend12.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hello,

My name is stern Arrnlund Head of Department, purchase. We would
like to know if you export to Sweden, as we need some of your
products for our client, kindly gives us a reply so we can send
you the full specifications and details of what we would like to
purchase.



We would appreciate your prompt attention to this request, as we
should begin a cooperation as soon as possible.



thanks & best regards.





Sten Arnlund

Purchase Manager



stern.arnlund@gogreenwalter-se.com



a: Veddige by 2, Holmerskulle, 432 68 Sweden.

