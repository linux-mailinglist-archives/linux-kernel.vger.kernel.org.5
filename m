Return-Path: <linux-kernel+bounces-30548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96751832049
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 21:11:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F7EF28DEA1
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 20:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D259B2E645;
	Thu, 18 Jan 2024 20:10:48 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67BB92E621;
	Thu, 18 Jan 2024 20:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705608648; cv=none; b=ZMga7WxIOvIU6+uw9ysOIWGPHNv0ksROtAYUR2cogCx3GQw9cbP7Bb5AKRa4wdC/mO5LlccmYK8yiSVeRulGk54p1c2eKQfNL8DJTIS5xPyAnaSUyIMI9I7fB8zv6GM7ALtpvmn+4IXDQHS7MaL1RiV45gIT4tvIfEP5uo+pi8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705608648; c=relaxed/simple;
	bh=1TzDWUaOgYWqlQoImJDsLdC0yNwNKD/lE82IuTEhcnQ=;
	h=From:Subject:Date:Message-ID:To; b=LV8p8vDtkZQG637pJm9WB4Uc/gmK/dLrwiVn+EKzRZxdkZH2bsMsPhdjXBCoAoHy91yTORESNUYfyYNs1LfmyR7Rs94m5WKzhxDOElqY++Pry550X4VqmFdnl5u8MSD7ml6Nd8L+iX7KOPJVZC0xkcXG9lGJV/TCZFteKtI4jwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF997C433F1;
	Thu, 18 Jan 2024 20:10:47 +0000 (UTC)
From: Clark Williams <williams@redhat.com>
Subject: [ANNOUNCE] 6.1.73-rt22
Date: Thu, 18 Jan 2024 20:09:51 -0000
Message-ID: <170560859123.510688.16443073192680432168@demetrius>
To: LKML <linux-kernel@vger.kernel.org>,linux-rt-users <linux-rt-users@vger.kernel.org>,Steven Rostedt <rostedt@goodmis.org>,Thomas Gleixner <tglx@linutronix.de>,Carsten Emde <C.Emde@osadl.org>,John Kacur <jkacur@redhat.com>,Sebastian Andrzej Siewior <bigeasy@linutronix.de>,Daniel Wagner <daniel.wagner@suse.com>,Tom Zanussi <tom.zanussi@linux.intel.com>,Clark Williams <williams@redhat.com>,Pavel Machek <pavel@denx.de>,Joseph Salisbury <joseph.salisbury@canonical.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Hello RT-list!

I'm pleased to announce the 6.1.73-rt22 stable release.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v6.1-rt
  Head SHA1: 55e7b6990ce43d64e83401c05ec992c4f0d74b36

Or to build 6.1.73-rt22 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v6.x/linux-6.1.tar.xz

  https://www.kernel.org/pub/linux/kernel/v6.x/patch-6.1.73.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/6.1/patch-6.1.73-rt22.patch.xz


Enjoy!
Clark

