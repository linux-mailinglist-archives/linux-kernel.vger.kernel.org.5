Return-Path: <linux-kernel+bounces-123439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7F6D8908A6
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 19:54:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6649829C6F1
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 18:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7A4E137904;
	Thu, 28 Mar 2024 18:54:04 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7041C6519D;
	Thu, 28 Mar 2024 18:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711652044; cv=none; b=Yq9ncDjE5IfnRy5rYww5y3mvOXAmPqVyrGO9FxUMHJIQksilUDRZq95C5kSQMBzGtADconluEDmOizimxfZNUIzwufJHNHlM4XyVsLQ8M3QAC1AmdZaONjvl21NM8NONs8Lpt5lQzsxEUnXIUdqHDXKWbtU9XIanq8iRC4r9LmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711652044; c=relaxed/simple;
	bh=lFoNmnhybrsQAR3e8HQxaFA1WHcDSFiWnEXEnJvAjP8=;
	h=From:Subject:Date:Message-ID:To; b=U8hwdKYeaVheeIrKE0+P9iyVKk72xgapOx6WW6yFmEv5wHVWlzbxEefBtHvoiA9bB4K1jpeMbgx4BhE+4RlAvL8q4HuSqDrEaZ1GCuA56fCcGKXFzfJ1BUy8RcJuoHGNxtk8ImiQmwkq1bnamLyM3YVKIocWFI4sr+6f+5zQ5fI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC38CC433C7;
	Thu, 28 Mar 2024 18:54:03 +0000 (UTC)
From: Clark Williams <williams@redhat.com>
Subject: [ANNOUNCE] 6.6.23-rt28
Date: Thu, 28 Mar 2024 18:53:03 -0000
Message-ID: <171165198340.1225016.14388264151176323360@demetrius>
To: LKML <linux-kernel@vger.kernel.org>,linux-rt-users <linux-rt-users@vger.kernel.org>,Steven Rostedt <rostedt@goodmis.org>,Thomas Gleixner <tglx@linutronix.de>,Carsten Emde <C.Emde@osadl.org>,John Kacur <jkacur@redhat.com>,Sebastian Andrzej Siewior <bigeasy@linutronix.de>,Daniel Wagner <daniel.wagner@suse.com>,Tom Zanussi <tom.zanussi@linux.intel.com>,Clark Williams <williams@redhat.com>,Pavel Machek <pavel@denx.de>,Joseph Salisbury <joseph.salisbury@canonical.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Hello RT-list!

I'm pleased to announce the 6.6.23-rt28 stable release.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v6.6-rt
  Head SHA1: a548d04719e0c9b8d3e784c8b62a85ec831b9a12

Or to build 6.6.23-rt28 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v6.x/linux-6.6.tar.xz

  https://www.kernel.org/pub/linux/kernel/v6.x/patch-6.6.23.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/6.6/patch-6.6.23-rt28.patch.xz


Enjoy!
Clark

