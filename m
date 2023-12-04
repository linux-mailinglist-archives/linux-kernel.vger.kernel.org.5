Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A84B80359F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 14:55:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344599AbjLDNzR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 08:55:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233342AbjLDNzO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 08:55:14 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2E4C690;
        Mon,  4 Dec 2023 05:55:20 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0AF88152B;
        Mon,  4 Dec 2023 05:56:07 -0800 (PST)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 6E9FB3F5A1;
        Mon,  4 Dec 2023 05:55:18 -0800 (PST)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     cristian.marussi@arm.com, Sibi Sankar <quic_sibis@quicinc.com>
Cc:     Sudeep Holla <sudeep.holla@arm.com>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_mdtipton@quicinc.com,
        linux-arm-kernel@lists.infradead.org, quic_asartor@quicinc.com,
        quic_lingutla@quicinc.com
Subject: Re: (subset) [PATCH 0/3] firmware: arm_scmi: Miscellaneous fixes and opp count increase
Date:   Mon,  4 Dec 2023 13:55:14 +0000
Message-ID: <170169805641.32343.17556834929598900222.b4-ty@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231129065748.19871-1-quic_sibis@quicinc.com>
References: <20231129065748.19871-1-quic_sibis@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Nov 2023 12:27:45 +0530, Sibi Sankar wrote:
> The patch series includes bug fixes identified while testing the
> performance protocol on the X1E80100 SoC. It also includes an
> increase of the maximum opps count to the next log level.
>
> base tree: next-20231129
>
> Sibi Sankar (3):
>   firmware: arm_scmi: Fix null pointer dereference during fastchannel init
>   firmware: arm_scmi: Fix freq/power truncation in the perf protocol
>   firmware: arm_scmi: Increase the maximum opp count
>
> [...]

Applied to sudeep.holla/linux (for-next/scmi/updates), thanks!

[1/3] firmware: arm_scmi: Fix null pointer dereference during fastchannel init
      https://git.kernel.org/sudeep.holla/c/3cc12bb83e67
[3/3] firmware: arm_scmi: Increase the maximum opp count
      https://git.kernel.org/sudeep.holla/c/c3f17d5f89fc
--
Regards,
Sudeep

