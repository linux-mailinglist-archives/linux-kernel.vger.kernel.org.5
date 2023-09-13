Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C3F979E0EE
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 09:37:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237775AbjIMHg5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 03:36:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237103AbjIMHgz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 03:36:55 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 855341727;
        Wed, 13 Sep 2023 00:36:51 -0700 (PDT)
Date:   Wed, 13 Sep 2023 09:36:40 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1694590604;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=bmLhWNMdCNCt+b18kzcGWD6nsvJhmYroDlitMnMerXg=;
        b=QMg10drs1H8OelN7dqFkjCJxlKaJAlQwQpfA6uEi4MGFXPvLBD7mwFyDwO3lG9lEXbZ/Dw
        Nds4esAvx/+95nLXdjzwSHe8pai2IVppi5s0VVZrNiHoGzZmPFNVp3W8MFS/UfnNS/UsNg
        LUQpImu0g9P+zSlFral7tFM0aTgT+4H2VHLbzWs0Rd7dCKyshzBAP0PgnbQhk/PJVe3GU4
        EmxyOs/4YTK+kZzrv/37n+y7FGBmMbz3ZYDa8istupmX6MsnZ3GrmA2r+uauHt/2lWw+iu
        GyFlq3g0C93MA/ThHXbkywVpOeHxvDHPlxLuJ8FShhepBO1etqiZ5i7WE6BNtA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1694590604;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=bmLhWNMdCNCt+b18kzcGWD6nsvJhmYroDlitMnMerXg=;
        b=dEnFiMN6OlOkovlszaeFzM4G+MzAYPsRwjD8CXt/e/QS75MAxuNi1REYD9KS392DyJvvIQ
        SBwYTWUeGQ1ci7BA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] v6.6-rc1-rt1
Message-ID: <20230913073640.aAHOYCgP@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear RT folks!

I'm pleased to announce the v6.6-rc1-rt1 patch set. 

Changes since v6.5.2-rt8:

  - Update to v6.6-rc1.

Known issues
     None

You can get this release via the git tree at:

    https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v6.6-rc1-rt1

The RT patch against v6.6-rc1 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/6.6/older/patch-6.6-rc1-rt1.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/6.6/older/patches-6.6-rc1-rt1.tar.xz

Sebastian
