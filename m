Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3D957F6712
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 20:26:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbjKWT0H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 14:26:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230001AbjKWT0G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 14:26:06 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB28F91
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 11:26:12 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F051C433C9;
        Thu, 23 Nov 2023 19:26:10 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kselftest/arm64: Fix output formatting for za-fork
Date:   Thu, 23 Nov 2023 19:26:08 +0000
Message-Id: <170076756598.3159824.7681360032827191396.b4-ty@arm.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231116-arm64-fix-za-fork-output-v1-1-42c03d4f5759@kernel.org>
References: <20231116-arm64-fix-za-fork-output-v1-1-42c03d4f5759@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Nov 2023 12:52:29 +0000, Mark Brown wrote:
> The za-fork test does not output a newline when reporting the result of
> the one test it runs, causing the counts printed by kselftest to be
> included in the test name.  Add the newline.
> 
> 

Applied to arm64 (for-next/fixes), thanks!

[1/1] kselftest/arm64: Fix output formatting for za-fork
      https://git.kernel.org/arm64/c/460e462d2254

-- 
Catalin

