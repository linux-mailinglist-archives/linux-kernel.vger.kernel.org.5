Return-Path: <linux-kernel+bounces-79469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E0CB8622A8
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 05:58:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC520B22933
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 04:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 501F514AA9;
	Sat, 24 Feb 2024 04:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a1UR/3pJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8238B4414;
	Sat, 24 Feb 2024 04:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708750679; cv=none; b=TkfT5mk6q1jfh6EOKWWNRwz++JCjx6Dls2nisDc/4l3YgfaSqy8SQqneYCyqpPv6Eq8KUFC7A1KZ90KG3E8A6VVDT0qXBoZzzti2I0aAbLvuPMYCQlY9dPlF2iLRlmBTGPdVqQGxMIBRRFoouT3zv2xK0qpMrTNdZxpM/NFrrXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708750679; c=relaxed/simple;
	bh=8hDMnouKPbHPnyxlE68+BvoZeduSM1zVCNBP2Wgdu80=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EycfbIWp3lYHuTg5ji3u/OWH+kEuXNWbD1x0426otd7UA/MokJRHaljlWn8wK2ZYxDjREhBOa3yHkhb5kpnjbfIImvS9O4YxW1faF7lE3Yb2c5cFAklPl7WhNK9FmGfANwcqJf3KNUBsLJkIrRP3ISqwsJSgHoMA7GKbvvnhl1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a1UR/3pJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FB04C433C7;
	Sat, 24 Feb 2024 04:57:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708750678;
	bh=8hDMnouKPbHPnyxlE68+BvoZeduSM1zVCNBP2Wgdu80=;
	h=From:To:Cc:Subject:Date:From;
	b=a1UR/3pJt2k9v0ChbtLypLRNeJsCElcIV5XoyI0Bm0VrbDBOevEM5aTfyJ8OAz2T2
	 B8Xi2dADU43UhLfNR23K9p0QousRIFNNkrIiyk6OiJktCzZV8izbp3anCNTpsJ+vOO
	 ZfsGzFRlYbURMPGlqNo1RjHuZ9UjBg7cC+uzW07t3hkq02palghO5wH992odm7p/RN
	 9oH0n1GkQa4gyD0Qm6GNhgGtuXpL5Jj2PKjk5/vBfZbRrZqqrldWJPl8Bc6XwzFOvl
	 mBw9DvHTWdpKAz55Xzbyj2TyOX0ieoVR4MPYdA9YXEoJMh0w86t3aX6k2FoEZr/KPN
	 Ef4+/3AnQBfRw==
From: neeraj.upadhyay@kernel.org
To: paulmck@kernel.org,
	frederic@kernel.org,
	joel@joelfernandes.org,
	boqun.feng@gmail.com,
	josh@joshtriplett.org
Cc: rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>
Subject: [PATCH] MAINTAINERS: Update Neeraj's email address
Date: Sat, 24 Feb 2024 10:27:30 +0530
Message-Id: <20240224045730.29812-1-neeraj.upadhyay@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Neeraj Upadhyay <neeraj.upadhyay@kernel.org>

Update my email-address in MAINTAINERS and .mailmap entries to my
kernel.org account.

Signed-off-by: Neeraj Upadhyay <neeraj.upadhyay@kernel.org>
---
 .mailmap    | 3 ++-
 MAINTAINERS | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/.mailmap b/.mailmap
index 08f28f2999f0..dd6ea71c9271 100644
--- a/.mailmap
+++ b/.mailmap
@@ -441,7 +441,8 @@ Mythri P K <mythripk@ti.com>
 Nadia Yvette Chambers <nyc@holomorphy.com> William Lee Irwin III <wli@holomorphy.com>
 Naoya Horiguchi <naoya.horiguchi@nec.com> <n-horiguchi@ah.jp.nec.com>
 Nathan Chancellor <nathan@kernel.org> <natechancellor@gmail.com>
-Neeraj Upadhyay <quic_neeraju@quicinc.com> <neeraju@codeaurora.org>
+Neeraj Upadhyay <neeraj.upadhyay@kernel.org> <quic_neeraju@quicinc.com>
+Neeraj Upadhyay <neeraj.upadhyay@kernel.org> <neeraju@codeaurora.org>
 Neil Armstrong <neil.armstrong@linaro.org> <narmstrong@baylibre.com>
 Nguyen Anh Quynh <aquynh@gmail.com>
 Nicholas Piggin <npiggin@gmail.com> <npiggen@suse.de>
diff --git a/MAINTAINERS b/MAINTAINERS
index 189184ecdb11..1006a6973320 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18461,7 +18461,7 @@ F:	tools/testing/selftests/resctrl/
 READ-COPY UPDATE (RCU)
 M:	"Paul E. McKenney" <paulmck@kernel.org>
 M:	Frederic Weisbecker <frederic@kernel.org> (kernel/rcu/tree_nocb.h)
-M:	Neeraj Upadhyay <quic_neeraju@quicinc.com> (kernel/rcu/tasks.h)
+M:	Neeraj Upadhyay <neeraj.upadhyay@kernel.org> (kernel/rcu/tasks.h)
 M:	Joel Fernandes <joel@joelfernandes.org>
 M:	Josh Triplett <josh@joshtriplett.org>
 M:	Boqun Feng <boqun.feng@gmail.com>
-- 
2.40.1


