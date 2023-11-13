Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E81217E9C19
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 13:25:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbjKMMZs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 07:25:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbjKMMZq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 07:25:46 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B122B1715
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 04:25:43 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DBF14FEC;
        Mon, 13 Nov 2023 04:26:28 -0800 (PST)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 8DD973F6C4;
        Mon, 13 Nov 2023 04:25:42 -0800 (PST)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sudeep Holla <sudeep.holla@arm.com>
Cc:     Jens Wiklander <jens.wiklander@linaro.org>,
        Coboy Chen <coboy.chen@mediatek.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>
Subject: Re: [PATCH 0/4] firmware: arm_ffa: Few fixes for FF-A notification support
Date:   Mon, 13 Nov 2023 12:25:40 +0000
Message-ID: <169987803529.35505.8372374865461648200.b4-ty@arm.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231024-ffa-notification-fixes-v1-0-d552c0ec260d@arm.com>
References: <20231024-ffa-notification-fixes-v1-0-d552c0ec260d@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Oct 2023 11:56:16 +0100, Sudeep Holla wrote:
> These are set of small fixes around FF-A notification support that are
> currently queued in -next. It is mostly to take care of absence of
> the notification support in the firmware as well as allowing them to be
> optional and continue initialisation even when the notification fails.
> 
> Regards,
> Sudeep
>
> [...]

Applied to sudeep.holla/linux (for-next/ffa/fixes), thanks!

[1/4] firmware: arm_ffa: Allow FF-A initialisation even when notification fails
      (Dropped redundant return before applying as suggested by Jens)
      https://git.kernel.org/sudeep.holla/c/95520fc07743
[2/4] firmware: arm_ffa: Setup the partitions after the notification initialisation
      https://git.kernel.org/sudeep.holla/c/6f47023f7a52
[3/4] firmware: arm_ffa: Add checks for the notification enabled state
      https://git.kernel.org/sudeep.holla/c/f4bfcaee34bc
[4/4] firmware: arm_ffa: Fix FFA notifications cleanup path
      https://git.kernel.org/sudeep.holla/c/6d67cbe67a86
--
Regards,
Sudeep

