Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A97317BBA48
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 16:31:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232547AbjJFObB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 10:31:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232511AbjJFOa5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 10:30:57 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3E102DB;
        Fri,  6 Oct 2023 07:30:55 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2A514C15;
        Fri,  6 Oct 2023 07:31:34 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 4A6D93F641;
        Fri,  6 Oct 2023 07:30:53 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Cristian Marussi <cristian.marussi@arm.com>,
        Viresh Kumar <vireshk@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Sudeep Holla <sudeep.holla@arm.com>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Nikunj Kela <nkela@quicinc.com>,
        Prasad Sodagudi <psodagud@quicinc.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH 0/9] PM: domains/opp/arm_scmi: Extend performance scaling support
Date:   Fri,  6 Oct 2023 15:30:50 +0100
Message-ID: <169660252494.691626.9269196598560953746.b4-ty@arm.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230925131715.138411-1-ulf.hansson@linaro.org>
References: <20230925131715.138411-1-ulf.hansson@linaro.org>
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

On Mon, 25 Sep 2023 15:17:06 +0200, Ulf Hansson wrote:
> Consumer drivers for devices that are attached to the SCMI performance domain,
> are currently not able to use the OPP library to scale performance. This series
> is enabling the support for this.
> 
> The OPPs for SCMI performance domain are encoded in the FW, rather than being
> described through DT. To better support this, some changes have also been done
> to the OPP library and for PM domains in general. More details are available in
> the commit messages.
> 
> [...]

Applied to sudeep.holla/linux (for-next/scmi/updates), thanks!

[1/9 - 6/9] Merged via branch 'opp/pm-domain-scmi' of git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm

[7/9] firmware: arm_scmi: Simplify error path in scmi_dvfs_device_opps_add()
      https://git.kernel.org/sudeep.holla/c/033ca4de1296
[8/9] firmware: arm_scmi: Specify the performance level when adding an OPP
      https://git.kernel.org/sudeep.holla/c/5a6a10419352
[9/9] firmware: arm_scmi: Add generic OPP support to the SCMI performance domain
      https://git.kernel.org/sudeep.holla/c/0a81b0eb81ca
--
Regards,
Sudeep

