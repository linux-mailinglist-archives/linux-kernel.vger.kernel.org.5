Return-Path: <linux-kernel+bounces-110310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 132D1885CFD
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 17:07:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F6371C22F56
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 16:07:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04CD612C55C;
	Thu, 21 Mar 2024 16:05:13 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70CB212BF23;
	Thu, 21 Mar 2024 16:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711037112; cv=none; b=INvMoHYGBmQuI0oF/xA6Z53MeDP4D2t+zvh9AyoITUKBLjhzHWKU22xgxgPSs+NJgd2t9TwTdWEgEpS8DynbsDTQ1xaTB2RLXKq4Uv61QEcLOPoDhqO1aaclVHsKO9MiYZIYzR5bjhEU4Tqa/qN096nQJ/B9E6Gfap7/m+r/Kio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711037112; c=relaxed/simple;
	bh=Q1uv+O/dHBWaJvBnvmI1QRDCpnTX0isK4IGgEzM3Dr8=;
	h=From:Subject:Date:Message-ID:To; b=kEMssmEaOQL6o5Rzi/SivOieiK8GEOUIf+vuWfUxdG1TboXUyeTnh3wbumxGP5o6clv5eHB5E3E84kZBHDauSuJQMRmJiifiY36gWSjAhYDLrmBgVw2j+GKh+r/piCMRlI3SYK/yz6UxH53HzK3zvPeJZbiy0gPgg67TDxbC1MM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCDA0C433C7;
	Thu, 21 Mar 2024 16:05:11 +0000 (UTC)
From: Clark Williams <williams@redhat.com>
Subject: [ANNOUNCE] 6.1.82-rt27
Date: Thu, 21 Mar 2024 16:04:35 -0000
Message-ID: <171103707508.785584.15617230440767284830@demetrius>
To: LKML <linux-kernel@vger.kernel.org>,linux-rt-users <linux-rt-users@vger.kernel.org>,Steven Rostedt <rostedt@goodmis.org>,Thomas Gleixner <tglx@linutronix.de>,Carsten Emde <C.Emde@osadl.org>,John Kacur <jkacur@redhat.com>,Sebastian Andrzej Siewior <bigeasy@linutronix.de>,Daniel Wagner <daniel.wagner@suse.com>,Tom Zanussi <tom.zanussi@linux.intel.com>,Clark Williams <williams@redhat.com>,Pavel Machek <pavel@denx.de>,Joseph Salisbury <joseph.salisbury@canonical.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Hello RT-list!

I'm pleased to announce the 6.1.82-rt27 stable release.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v6.1-rt
  Head SHA1: bc2a7427135b003fb19f98a42b8f61d21ec3e7c6

Or to build 6.1.82-rt27 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v6.x/linux-6.1.tar.xz

  https://www.kernel.org/pub/linux/kernel/v6.x/patch-6.1.82.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/6.1/patch-6.1.82-rt27.patch.xz


Enjoy!
Clark

