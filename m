Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D6BD76CA9D
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 12:18:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233006AbjHBKSW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 06:18:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230112AbjHBKSU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 06:18:20 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 624652137;
        Wed,  2 Aug 2023 03:18:19 -0700 (PDT)
Date:   Wed, 2 Aug 2023 12:18:14 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1690971497;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=ZU6aHlcD9DgHPUVEz1ioJ4dnMxLQQ9CcpX35nHpDveo=;
        b=fkkBdwV4agyzYlryyq57bqAtbrr9uLNupHpgybnYUoP8c0xd+TSCu0ws2D+HOolsmKreJc
        p7DlNUd4CEnIa7gumYa7QzNaOHo2MsjCBn+iCn6L47cIOEmvkuPH8XV0JwQROZA6GhRGAl
        pczxSiY9t+WNKLTPhWM1zAs283qilHU2UCp5fpsq+uIZA6+71obF9y/R+EIEL4Z2Fqp6To
        HR1kIjdNsnK+FG2VkNC7I0Lk9qXl5E9aIYNWCGXoqaF1TMG0mrZOnTOinaYb3p8jJflsjq
        kYaUGOafUR2YRZtYnk2DHPU7bF4DhY4YH222ZWBzneqVdR7bdvycqAiimQqV/w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1690971497;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=ZU6aHlcD9DgHPUVEz1ioJ4dnMxLQQ9CcpX35nHpDveo=;
        b=iYq/ZkjGWo4GW+q1BhzcExSQ/sXJVOROXgvR5wCGL8JT3jG5nw1vgAm5aG4XZHisn788bZ
        6936NVrwanfJDEBw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] v6.5-rc4-rt1
Message-ID: <20230802101814.ROZkuDtk@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear RT folks!

I'm pleased to announce the v6.5-rc4-rt1 patch set. 

Changes since v6.4.6-rt8:

  - Update to v6.5-rc4.

Known issues
     None

You can get this release via the git tree at:

    https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v6.5-rc4-rt1

The RT patch against v6.5-rc4 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/6.5/older/patch-6.5-rc4-rt1.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/6.5/older/patches-6.5-rc4-rt1.tar.xz

Sebastian
