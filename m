Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A31A759258
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 12:07:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbjGSKHG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 06:07:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjGSKHE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 06:07:04 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C092CEC
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 03:07:03 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C4B342F4;
        Wed, 19 Jul 2023 03:07:46 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 632FC3F67D;
        Wed, 19 Jul 2023 03:07:02 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Yangtao Li <frank.li@vivo.com>, Liviu Dudau <liviu.dudau@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/7] [PATCH 6/7] bus: vexpress-config: Convert to devm_platform_ioremap_resource()
Date:   Wed, 19 Jul 2023 11:06:59 +0100
Message-ID: <168976104705.3013544.1925006018431804113.b4-ty@arm.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230706072042.31296-6-frank.li@vivo.com>
References: <20230706072042.31296-6-frank.li@vivo.com>
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

On Thu, 06 Jul 2023 15:20:36 +0800, Yangtao Li wrote:
> Use devm_platform_ioremap_resource() to simplify code.
>

Applied to sudeep.holla/linux (for-next/vexpress/updates), thanks!

[6/7] bus: vexpress-config: Convert to devm_platform_ioremap_resource()
      https://git.kernel.org/sudeep.holla/c/bc0e769647d7
--
Regards,
Sudeep

