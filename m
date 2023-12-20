Return-Path: <linux-kernel+bounces-6925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 15EB9819F64
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 13:56:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ADBC3B2443D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 12:56:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5BB625569;
	Wed, 20 Dec 2023 12:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=monom.org header.i=@monom.org header.b="f1rPHDcW"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail.nearlyone.de (mail.nearlyone.de [49.12.199.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E4EF24B4C;
	Wed, 20 Dec 2023 12:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=monom.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=monom.org
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id CB8ECE2092;
	Wed, 20 Dec 2023 13:46:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1703076420; h=from:subject:date:message-id:to:mime-version:content-type;
	bh=e3hnxaD4xgct/ovUmvI4AiLnTRKSaJT8zLm5qcJ8cRU=;
	b=f1rPHDcWORB1pClhiSwa4iKvfGQhYDyzi+NnLkXz3m+3VcNOPvBK5KDVIyPpcqftv5pbTr
	ZCeN81EgzLKerMXrrSniIpnhzQQyOrp+6L71ctn+37vDvBAcjew8XGjJb7oB0ktL85inPC
	y0i30suZixSaUWS5/9QtndrdLfDyyc96mVNU/wt7mxSJRh+Kf7jHuOt7UwwbWJYfDEajfh
	MUamzhGXz6+GpKERath5eHsBK4ViEVkY9iR3ik3hjf/PKz3lOqV/jLp4PqLgsxt60RKY1n
	/DsFqKkEyRZh1b7O0LziDTkWaXJyP07AkXyb3z6tqC8eBOdzclu8ue/wuoLNPQ==
Date: Wed, 20 Dec 2023 13:46:56 +0100
From: Daniel Wagner <wagi@monom.org>
To: LKML <linux-kernel@vger.kernel.org>, linux-rt-users@vger.kernel.org, 
	stable-rt@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Tom Zanussi <tom.zanussi@linux.intel.com>, Clark Williams <williams@redhat.com>
Subject: [ANNOUNCE] 4.19.302-rt131
Message-ID: <170307633790.6193.437447257232223288@beryllium.lan>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Last-TLS-Session-Version: TLSv1.3

Hello RT-list!

I'm pleased to announce the 4.19.302-rt131 stable release.

This is just an update to the v4.19.302 stable release. No RT specific
changes.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.19-rt
  Head SHA1: 5cb4bf59d366acdf4ba96cb0d98962379bd9645d

Or to build 4.19.302-rt131 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v4.x/linux-4.19.tar.xz

  https://www.kernel.org/pub/linux/kernel/v4.x/patch-4.19.302.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.19/older/patch-4.19.302-rt131.patch.xz

Signing key fingerprint:

  5BF6 7BC5 0826 72CA BB45  ACAE 587C 5ECA 5D0A 306C

All keys used for the above files and repositories can be found on the
following git repository:

   git://git.kernel.org/pub/scm/docs/kernel/pgpkeys.git

Enjoy!
Daniel

Changes from v4.19.299-rt130:

