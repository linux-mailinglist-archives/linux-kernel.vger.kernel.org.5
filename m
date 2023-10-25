Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C2717D6852
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 12:23:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234591AbjJYKXN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 06:23:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234765AbjJYKXK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 06:23:10 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 585B5133;
        Wed, 25 Oct 2023 03:23:07 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 89C622F4;
        Wed, 25 Oct 2023 03:23:48 -0700 (PDT)
Received: from ewhatever.cambridge.arm.com (ewhatever.cambridge.arm.com [10.1.197.1])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2B3F93F738;
        Wed, 25 Oct 2023 03:23:05 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     Vegard Nossum <vegard.nossum@oracle.com>,
        James Clark <james.clark@arm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>
Cc:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Rob Herring <robh@kernel.org>, linux-next@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        coresight@lists.linaro.org, Bagas Sanjaya <bagasdotme@gmail.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] Documentation: coresight: fix `make refcheckdocs` warning
Date:   Wed, 25 Oct 2023 11:22:58 +0100
Message-Id: <169822933857.1034160.3403162246567541571.b4-ty@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231022185806.919434-1-vegard.nossum@oracle.com>
References: <20231022185806.919434-1-vegard.nossum@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 22 Oct 2023 20:58:06 +0200, Vegard Nossum wrote:
> This reference uses a glob pattern to match multiple files, but the
> asterisk was escaped as \* in order to not be interpreted by sphinx
> as reStructuredText markup.
> 
> refcheckdocs/documentation-file-ref-check doesn't know about rST syntax
> and tries to interpret the \* literally (instead of as a glob).
> 
> [...]

Applied, thanks!

[1/1] Documentation: coresight: fix `make refcheckdocs` warning
      https://git.kernel.org/coresight/c/fa55e63584f2

Best regards,
-- 
Suzuki K Poulose <suzuki.poulose@arm.com>
