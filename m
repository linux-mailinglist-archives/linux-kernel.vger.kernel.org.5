Return-Path: <linux-kernel+bounces-153358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 358458ACD18
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 14:44:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5E92285170
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 12:44:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B088F14F133;
	Mon, 22 Apr 2024 12:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sendemailfast77.com header.i=@sendemailfast77.com header.b="WnFq1Zhm"
Received: from sendemailfast77.com (sendemailfast77.com [144.217.241.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B810149C6C
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 12:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.217.241.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713789661; cv=none; b=DuGh/xUHAZFlklGBV2oCTC8JOi6K64PNobkRtQVgT+0vUPrf9lqag5bzEZGs/zki/Kto9WLSn5vbNUtwEOzPAEACq/hGcn4Z+4nV2JAAZn/5jFVz9T/4ztm0Guf3zPkzZqSYfdIXHEDBbEEpxbMKCBLniEXWJZxa1eH5/V1jahY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713789661; c=relaxed/simple;
	bh=zDEe5rGq4RUs51Fes9UeTv4jjGsR2LHXqDLxJvD7x1Q=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oECDRwcrviYqT9HVjpXddvFrHHEdnEmbZHJOEurwAAJhbBTgySfaOhHJy0sLi9n4/w1XaWETDMe1jo0wEJepdyRpbuPZr3peQ/uhm3NtI0uFrGYuM5PUoNU+WOY6WXpBX6XohTxY9sp7dcbo7T72KYtnxGof5inw5DsofhX4CSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sendemailfast77.com; spf=pass smtp.mailfrom=sendemailfast77.com; dkim=pass (2048-bit key) header.d=sendemailfast77.com header.i=@sendemailfast77.com header.b=WnFq1Zhm; arc=none smtp.client-ip=144.217.241.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sendemailfast77.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sendemailfast77.com
Received: from sendemailfast77.com (unknown [103.96.83.38])
	by sendemailfast77.com (Postfix) with ESMTPSA id 05862634FF
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 11:58:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 sendemailfast77.com 05862634FF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sendemailfast77.com;
	s=default; t=1713787112;
	bh=zDEe5rGq4RUs51Fes9UeTv4jjGsR2LHXqDLxJvD7x1Q=;
	h=Reply-To:From:To:Subject:Date:From;
	b=WnFq1Zhm6mf6/ZRP2tJpzmfRTsjkq9HmxN4Nakskefqc26+eakEElnpL4ZmuEadIF
	 bZnLX4VdFNdRqOqenPwedG+xc5jZY4osEE3EtkKlBv6Rrp02lXMylWbbIP2UwGETuU
	 kTX2ISEC/t2FU+Z1iPoMBabO6HlRf2Tiv7W9ThpdPVWuSypdTPzPgSRCOFQsuWyAK0
	 UM3S/+eROiXL+R5StDUAqRefBSQAd0dEAo4UOAllMqXv34Pe3WVw/H7ZQl7Tj+NNii
	 SPIYBt8FzK/93+QgNFoTq8SMgfzES2zHbYV/CKei1aU1xNFox5E4a2WZ9rDlT2ta96
	 VJw+NgSX7ZgKA==
Reply-To: stern.arnlund@gogreenwalter-se.com
From: sale@sendemailfast77.com
To: linux-kernel@vger.kernel.org
Subject: New inquiry from sweden
Date: 22 Apr 2024 21:58:30 +1000
Message-ID: <20240422215829.20A8D4449CFF4049@sendemailfast77.com>
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

My name is stern Arrnlund Head of Department, purchase. We would=20
like to know if you export to Sweden, as we need some of your=20
products for our client, kindly gives us a reply so we can send=20
you the full specifications and details of what we would like to=20
purchase.


We would appreciate your prompt attention to this request, as we=20
should begin a cooperation as soon as possible.


thanks & best regards.


Sten Arnlund

Purchase Manager


stern.arnlund@gogreenwalter-se.com


a: Veddige by 2, Holmerskulle, 432 68 Sweden.

