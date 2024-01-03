Return-Path: <linux-kernel+bounces-15877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB9728234C5
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 19:45:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB63C1C23B92
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 18:45:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A21ED1CA93;
	Wed,  3 Jan 2024 18:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="dGO7Ca/T"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B8C51C6AE;
	Wed,  3 Jan 2024 18:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from canonical.com (1.general.jsalisbury.us.vpn [10.172.66.188])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id F15373F6D7;
	Wed,  3 Jan 2024 18:36:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1704306980;
	bh=8uE8EdR+iQ3/vRgCWahopVKlj6kNvivr4rCWFetI0C8=;
	h=From:Subject:Date:Message-ID:To;
	b=dGO7Ca/T/cK5nbJ8v11AJCIVB79pYTju/ZBTsWTa0dcP4xHRZdd9iX0mwIRLrFxiB
	 PykW5bqQVLVsYV00TGJz5LEuC6chbPSh8OsSiMjfR47w8qzX2XalBLOHeRpsTXHmnz
	 Uyx9tq7eNwnT2pJ4Du24BUSxqhF5omqyP1ZW8BZx0RhxGKQs1gvetFphRISyCLIJva
	 xKNIdSYq+7FYQoySau5eollE7PLnocHagweoce9kfNu+snj/4/50CbYdKYLJ1NqqK1
	 pIKOWYl5cB9fCco3qoJMATe5D9w4Y6VhpytfpmGq87stHyLyryWZ8eRbUJpDcJWePz
	 /js+SQQJpyVAA==
From: Joseph Salisbury <joseph.salisbury@canonical.com>
Subject: [ANNOUNCE] 5.15.145-rt73
Date: Wed, 03 Jan 2024 18:31:56 -0000
Message-ID: <170430671676.71812.4178110289387133033@jupiter.home.arpa>
To: LKML <linux-kernel@vger.kernel.org>,linux-rt-users <linux-rt-users@vger.kernel.org>,Steven Rostedt <rostedt@goodmis.org>,Thomas Gleixner <tglx@linutronix.de>,Carsten Emde <C.Emde@osadl.org>,John Kacur <jkacur@redhat.com>,Sebastian Andrzej Siewior <bigeasy@linutronix.de>,Daniel Wagner <daniel.wagner@suse.com>,Tom Zanussi <tom.zanussi@linux.intel.com>,Clark Williams <williams@redhat.com>,Pavel Machek <pavel@denx.de>,Joseph Salisbury <joseph.salisbury@canonical.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Hello RT-list!

I'm pleased to announce the 5.15.145-rt73 stable release.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v5.15-rt
  Head SHA1: 1d5fbef92eb36251829a2016062df2e7560b6067

Or to build 5.15.145-rt73 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v5.x/linux-5.15.tar.xz

  https://www.kernel.org/pub/linux/kernel/v5.x/patch-5.15.145.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/5.15/patch-5.15.145-rt73.patch.xz


Enjoy!
Joseph Salisbury

