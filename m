Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82AE278C11D
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 11:20:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234572AbjH2JTe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 05:19:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234656AbjH2JTS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 05:19:18 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F1E341AE;
        Tue, 29 Aug 2023 02:19:15 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2458E2F4;
        Tue, 29 Aug 2023 02:19:55 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B9D173F738;
        Tue, 29 Aug 2023 02:19:14 -0700 (PDT)
Date:   Tue, 29 Aug 2023 10:19:12 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     "Pawandeep Oza (QUIC)" <quic_poza@quicinc.com>
Cc:     "rafael@kernel.org" <rafael@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Subject: Re: ACPI binding with SCMI
Message-ID: <20230829091912.xefuenspdbazvqlh@bogus>
References: <20230807154834.888328-1-quic_poza@quicinc.com>
 <20230818091931.iqh6bxiifk4wyc32@bogus>
 <CH0PR02MB80732F4C4134B3EF2D80B4EDF6E3A@CH0PR02MB8073.namprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CH0PR02MB80732F4C4134B3EF2D80B4EDF6E3A@CH0PR02MB8073.namprd02.prod.outlook.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 25, 2023 at 09:34:59PM +0000, Pawandeep Oza (QUIC) wrote:

[...]

>
> But I still fail to see how fastchannel doorbell and shared memory space
> could get bind to PCC space (type 3) ? I am on 6.3 kernel.

They simply don't bind to PCC, PCC can't be fast channel. What exactly are you
looking for here ? If you provide more details on that, I can see if I can
help or suggest or may be explore along with you if the solution doesn't
exists yet.

-- 
Regards,
Sudeep
