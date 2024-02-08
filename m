Return-Path: <linux-kernel+bounces-58318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 26A2884E492
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 17:00:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A548EB25462
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 16:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ACBA7C0AE;
	Thu,  8 Feb 2024 16:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="bgWuKlUV"
Received: from out0-197.static.mail.aliyun.com (out0-197.static.mail.aliyun.com [59.82.0.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC22C7B3FF
	for <linux-kernel+bounces-58242-xuanzhuo=linux.alibaba.com@vger.kernel.org>; Thu,  8 Feb 2024 16:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=59.82.0.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707408016; cv=none; b=KOcNp0xNC5K/ozNhrHidcknjl7Qu5/yV21bz3n1rL3jZkDmPgIpJiDcJUICH0rdzESyE5mtYSxDdk1g+6HW9RpIi6OGurdHvLGVlrpesW2O7H/GrpoFcTtl5KoRrlt8VvnxZ7XcHhF5jGyojxJCPtFhTDxIjwL6ElUIE/g1qHc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707408016; c=relaxed/simple;
	bh=a+BuHGTS9P2uQPIBTFfFeLBBud0i07Omu7OakIuFqGU=;
	h=date:from:subject:to:message-id:MIME-Version:Content-Type; b=hMvH7W5vBVBE0xSz9z71UShc7gaQRcR4rZDci92Fq5tLOnJKAIJmsdkKPPAzRDlDIE8jHPdgASsYCpxIOK0w/mg67aOB+FmXv3vzOzzLznrMbHX9gfigoppw1vJAMM81y/NCUlLEwwOIFNgJOHkoM47cwqTqYBLqRHM6wLq+8Ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=bgWuKlUV; arc=none smtp.client-ip=59.82.0.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1707408011; h=date:from:subject:to:message-id:MIME-Version:Content-Type;
	bh=a+BuHGTS9P2uQPIBTFfFeLBBud0i07Omu7OakIuFqGU=;
	b=bgWuKlUVUFnYXZQWgMlKpzITvh0FUfBidv66xxCN9k2RrYYzr0431mWkKQPEuOgeyXnyUVDo6dHMu2dbqc8BZv8JoNqevIbdypIMh6XqGkpbR15pFlBQmezC8p+8XoxRDslOkSrHoyfd8N9TBa9RQG+5zg4gmiZWfs6tzpaZqAc=
auto-submitted:auto-replied
date:Fri, 09 Feb 2024 00:00:10 +0800
from: <xuanzhuo@linux.alibaba.com>
subject:=?UTF-8?B?UmU6UmU6IFtQQVRDSCB2Ml0gdGhlcm1hbDogc3lzZnM6IE1ha2UgdHJpcCBoeXN0ZXJlc2lzIHdyaXRhYmxlIGFsb25nIHdpdGggdHJpcCB0ZW1wZXJhdHVyZQ==?=
to:linux-kernel@vger.kernel.org
message-id: 24df5985-f1d3-4fb3-a16c-71dd4449db35
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version:1.0
Content-Type:text/plain;
	charset="utf-8"

Hi, I'm on vacation. I'll get back to you when I'm done with this vacation.
I'll be back on 2.18.

Thanks.

