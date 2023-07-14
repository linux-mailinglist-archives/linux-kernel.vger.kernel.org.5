Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83E29753944
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 13:09:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232770AbjGNLJH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 07:09:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229973AbjGNLJF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 07:09:05 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 781DD12D;
        Fri, 14 Jul 2023 04:09:04 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7496D1570;
        Fri, 14 Jul 2023 04:09:46 -0700 (PDT)
Received: from bogus (unknown [10.57.96.99])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CBF883F67D;
        Fri, 14 Jul 2023 04:09:01 -0700 (PDT)
Date:   Fri, 14 Jul 2023 12:08:37 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Avram Lubkin <avram@rockhopper.net>
Cc:     robh@kernel.org, linux-arm-kernel@lists.infradead.org,
        Sudeep Holla <sudeep.holla@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        conor+dt@kernel.org, liviu.dudau@arm.com,
        krzysztof.kozlowski+dt@linaro.org, lpieralisi@kernel.org
Subject: Re: Bug introduced in 724ba67 (ARM: dts: Move .dts files to vendor
 sub-directories)
Message-ID: <20230714110837.q2ya5lkucz4vs6jv@bogus>
References: <CAHqEdrPuH4ayMiiq5FixaNjM=r44VJOw-v3iQ0mek55FTUWpsw@mail.gmail.com>
 <CAHqEdrPD_EX=V0RnvvycN1MyXs0e+jkCcQ-nfHwOmyZR2LecfA@mail.gmail.com>
 <20230706084511.gp4iuvekkw7lwhdl@bogus>
 <CAHqEdrMmwHzDFUeMWxmXrpM273-yw9-rz-HFnQK+Br0rcf0m1w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHqEdrMmwHzDFUeMWxmXrpM273-yw9-rz-HFnQK+Br0rcf0m1w@mail.gmail.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 13, 2023 at 01:38:48PM -0400, Avram Lubkin wrote:
> Thanks for submitting a patch. I saw it was acked. Will that get
> merged soon? It shouldn't need to for the next merge window since it's
> fixing an issue, right?

Yes I will send it as fix soon, just queued for -next testing last night.

> Just wondering if I need to work around this or not.

Not for long, I hope it will be merged soonish after I send pull request.

--
Regards,
Sudeep
