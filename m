Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 201B27B5512
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 16:32:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237668AbjJBONh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 10:13:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231970AbjJBONc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 10:13:32 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3D95DD
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 07:13:29 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 780ADC433C9;
        Mon,  2 Oct 2023 14:13:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696256009;
        bh=pjqEGoT7owRHl5kIl5wpgRjhe3uk149Vxf1fmZRGq+0=;
        h=From:To:Cc:Subject:Date:From;
        b=bMBmn+tbDnLJr+0zGuN4GTVskyKpgsGwUXImz7geXCcKjySJOIdwjE6wcBQSkrqsy
         Vturt7K/SFtbeWqxaEfZVTk+Kwo8sTMFfHOYYj7boGeGGN/P9Q9gCQzvbRWeq/s3Iv
         kOOUvRc3Mpg8402aHpA+P5fw6ggfUXO+2TKauox512Z+Vk1xEziG7KhvC7cU4uEVVb
         982mj3bE6iqaWUAV0NJyEnE+vvtIdv5vMJLAXfmsZWQ2x13i82ldqmSDghUrWZppR4
         u4mBAQ94p+c5FWW7Sd9+jvd9ChbWD6ppk/0oVAr58qvfCFTHTzfxCPtX31VNRjMBq5
         u0m9bwv8xVncg==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <maz@kernel.org>)
        id 1qnJfq-000Nzy-JG;
        Mon, 02 Oct 2023 15:13:27 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 0/2] irqchip/irqdomain MAINTAINERS update
Date:   Mon,  2 Oct 2023 15:13:00 +0100
Message-Id: <20231002141302.3409485-1-maz@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: tglx@linutronix.de, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, will@kernel.org, catalin.marinas@arm.com, mark.rutland@arm.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As some people may have noticed, my IRQ-related bandwidth has been
pretty low over the past year, and is unlikely to go back to its
previous levels any time soon.

Being listed as a maintainer implies some level of responsiveness that
I cannot offer at the moment, so I'm removing myself from MAINTAINERS
entries related to the irqchip and irqdomain subsystems.

I'll keep maintaining the various ARM GICs, for which this series adds
a new entry in the MAINTAINERS file.

Marc Zyngier (2):
  MAINTAINERS: Add myself as the ARM GIC maintainer
  MAINTAINERS: Remove myself from the general IRQ subsystem maintenance

 MAINTAINERS | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

-- 
2.34.1

