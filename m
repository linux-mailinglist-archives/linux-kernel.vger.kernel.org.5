Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DB477A47FB
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 13:06:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241399AbjIRLGc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 07:06:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241234AbjIRLF6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 07:05:58 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2BD18F
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 04:05:53 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A12FFC433C8;
        Mon, 18 Sep 2023 11:05:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695035153;
        bh=/9LUukeh2GWUn00gCn5cevYoz4/9bRe0mShBMQkCHuM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jWguJ8dYjF2g7CNjWT3c4+hEmx4lJuXxQZa1y1vggbYZ2y6cugMzz9vJpacrMCVpn
         a7Fjwt9CKbt9vFigZctjvUOxAgzgcykgXcJ++ORlfTLKC/HWlCIRNbF1o++clyBW5r
         t77qhl+lK40MwH44upawWZ5lRI/kmbrZCClBp8Kgg+xyCqkg/pOKFkeU+7X5e2QHrC
         h2nVP6LKmltxMZj0NGdaR8Hh1yUqbkxOoJ9sUD08sqmIWRGl+XKZJqYgOEayKisJnn
         r/aaiaGhiRLFfV4jnh9w5uNiUq4RZpYW+OzmHQqZuUIKi0HweL4+7s+UjrKdqqJSER
         RmHZT8Ljm7zqw==
From:   Will Deacon <will@kernel.org>
To:     Oliver Upton <oliver.upton@linux.dev>
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Raghavendra Rao Ananta <rananta@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: Use wildcard pattern for ARM PMU headers
Date:   Mon, 18 Sep 2023 12:05:21 +0100
Message-Id: <169502989795.1327596.1044106414546404372.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230915202421.2706446-1-oliver.upton@linux.dev>
References: <20230915202421.2706446-1-oliver.upton@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Sep 2023 20:24:21 +0000, Oliver Upton wrote:
> Looks like arm_pmuv3.h isn't caught by the ARM PMU maintainers entry.
> Fix it with a wildcard.
> 
> 

Applied to arm64 (for-next/fixes), thanks!

[1/1] MAINTAINERS: Use wildcard pattern for ARM PMU headers
      https://git.kernel.org/arm64/c/215b215d1e92

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
