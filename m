Return-Path: <linux-kernel+bounces-104458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ECCCC87CE27
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 14:36:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA25A1C21121
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 13:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6680828E3E;
	Fri, 15 Mar 2024 13:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fq9guYqz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A608828DCF
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 13:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710509802; cv=none; b=FdwJfN/DjwWk+iGp2Zs4837eXslCrnugETOg3bssMQhjUM5CAOzTHzpAhfxUA0J82xVw1HYp4RCS1vrzke07EoDYdJPRdCSu3IDqO+46knkoCkrZUwjNhmjj2kfrI5/d4n7jI3ZpVzCSuZ07d915v9tIgb0jQE4Vw3yRXnGLano=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710509802; c=relaxed/simple;
	bh=2vLrjlglM4jtfGDpxEQlmCCOroNcS3fCuVdTMX3dGrc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Bleh7PNzF9WWD8Y6gGE4RXT9fs413wQlzA89seq9Cq8gMWkD7tjCah0Vk5qOdKDfJOKKtRYPVFC3SusVXJU7Pu1qsdTGRMWy2JxO+naocSE52EZ4X1BeTSSkX4x34dl71w7gOCs6Rkz7HwfE+3qhZ0x9xaN+GSXw9ia66UXEa4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fq9guYqz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9642C433C7;
	Fri, 15 Mar 2024 13:36:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710509802;
	bh=2vLrjlglM4jtfGDpxEQlmCCOroNcS3fCuVdTMX3dGrc=;
	h=From:To:Cc:Subject:Date:From;
	b=Fq9guYqz+5jWnftsHOjIRbIeCDIc6u3ZkJ5zz6wpQuJO5q1GudmRXsKZYQPE6nbKQ
	 sdzyi69oNvJfIH5++2Q41at37etd0l7KawrHryAqQeYKn2sA9eCoGHhujQC5ApIS+/
	 z9X3HjfOITo3NV163Kc/wsIolyQassnHVCk6yVTthQNxggwhfYn32ymqHOUMQNQFKB
	 h2Xu21sM/OB3XUK25Ed6yGmyaxDnqq2aecQdQdwyaFwZcM/lrQrHd6tsEasSrDmNqP
	 ZzQUChyPTPRdrychwiyZePD9omSuIqZt0jfTRdS7z0RyErBh1cWRw17xRfkwwF40tY
	 I0+QVyqEU7I6A==
From: qmo@kernel.org
To: Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Quentin Monnet <qmo@kernel.org>
Subject: [PATCH] MAINTAINERS: Update email address for Quentin Monnet
Date: Fri, 15 Mar 2024 13:36:05 +0000
Message-Id: <20240315133606.65971-1-qmo@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Quentin Monnet <qmo@kernel.org>

With Isovalent being acquired by Cisco, I expect my related email
address to disappear sooner or later. Update my email entries in
MAINTAINERS and .mailmap with my kernel.org address instead.

Signed-off-by: Quentin Monnet <qmo@kernel.org>
---
 .mailmap    | 3 ++-
 MAINTAINERS | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/.mailmap b/.mailmap
index 2216b5d5c84e..02cd23b76eda 100644
--- a/.mailmap
+++ b/.mailmap
@@ -497,7 +497,8 @@ Prasad Sodagudi <quic_psodagud@quicinc.com> <psodagud@codeaurora.org>
 Punit Agrawal <punitagrawal@gmail.com> <punit.agrawal@arm.com>
 Qais Yousef <qyousef@layalina.io> <qais.yousef@imgtec.com>
 Qais Yousef <qyousef@layalina.io> <qais.yousef@arm.com>
-Quentin Monnet <quentin@isovalent.com> <quentin.monnet@netronome.com>
+Quentin Monnet <qmo@kernel.org> <quentin.monnet@netronome.com>
+Quentin Monnet <qmo@kernel.org> <quentin@isovalent.com>
 Quentin Perret <qperret@qperret.net> <quentin.perret@arm.com>
 Rafael J. Wysocki <rjw@rjwysocki.net> <rjw@sisk.pl>
 Rajeev Nandan <quic_rajeevny@quicinc.com> <rajeevny@codeaurora.org>
diff --git a/MAINTAINERS b/MAINTAINERS
index 76b3714710c2..02dadb5de58b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3967,7 +3967,7 @@ F:	kernel/bpf/bpf_lru*
 F:	kernel/bpf/cgroup.c
 
 BPF [TOOLING] (bpftool)
-M:	Quentin Monnet <quentin@isovalent.com>
+M:	Quentin Monnet <qmo@kernel.org>
 L:	bpf@vger.kernel.org
 S:	Maintained
 F:	kernel/bpf/disasm.*
-- 
2.34.1


