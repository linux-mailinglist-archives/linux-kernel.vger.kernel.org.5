Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F5F67B583F
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 18:57:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238403AbjJBQZM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 12:25:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237864AbjJBQZL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 12:25:11 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 81B3A83;
        Mon,  2 Oct 2023 09:25:07 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 887C6C15;
        Mon,  2 Oct 2023 09:25:45 -0700 (PDT)
Received: from bogus (unknown [10.57.93.106])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D55463F762;
        Mon,  2 Oct 2023 09:25:05 -0700 (PDT)
Date:   Mon, 2 Oct 2023 17:23:35 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Cristian Marussi <cristian.marussi@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH v3 2/2] clk: scmi: add set/get_parent support
Message-ID: <20231002162335.er3kjee37yrsiceu@bogus>
References: <20231001-scmi-clock-v2-v3-0-898bd92d8939@nxp.com>
 <20231001-scmi-clock-v2-v3-2-898bd92d8939@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231001-scmi-clock-v2-v3-2-898bd92d8939@nxp.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

On Sun, Oct 01, 2023 at 12:38:44PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> SCMI v3.2 adds set/get parent clock commands, so update the clk driver
> to support them.
>

The SCMI changes look good. If you are happy with this driver change, please
Ack so that I can take it along with the SCMI changes. There are other patches
clk driver patches that you have already acked in my branch, hence the need to
route it via SCMI tree.

-- 
Regards,
Sudeep
