Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFA8B7B58EF
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 19:42:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238684AbjJBRNR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 13:13:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjJBRNP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 13:13:15 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 731C8AC;
        Mon,  2 Oct 2023 10:13:12 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AAC5CC15;
        Mon,  2 Oct 2023 10:13:50 -0700 (PDT)
Received: from pluto (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D20C53F59C;
        Mon,  2 Oct 2023 10:13:10 -0700 (PDT)
Date:   Mon, 2 Oct 2023 18:13:08 +0100
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH v3 1/2] firmware: arm_scmi: clock: support clock parents
Message-ID: <ZRr6JKR4uizvulcV@pluto>
References: <20231001-scmi-clock-v2-v3-0-898bd92d8939@nxp.com>
 <20231001-scmi-clock-v2-v3-1-898bd92d8939@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231001-scmi-clock-v2-v3-1-898bd92d8939@nxp.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 01, 2023 at 12:38:43PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> SCMI v3.2 spec introduces CLOCK_POSSIBLE_PARENTS_GET, CLOCK_PARENT_SET
> and CLOCK_PARENT_GET. This patch is to add the upper three new
> commands.
> 

Hi,

I tested this on some emulated setup and it works fine, can see well
formed SCMI messages going back and forth.

Reviewed-by: Cristian Marussi <cristian.marussi@arm.com>

Thanks,
Cristian
