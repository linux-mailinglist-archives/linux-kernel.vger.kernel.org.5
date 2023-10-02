Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 781F47B59B0
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 20:11:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238696AbjJBR7D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 13:59:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238620AbjJBR7B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 13:59:01 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DCC8EB4;
        Mon,  2 Oct 2023 10:58:58 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 232E9C15;
        Mon,  2 Oct 2023 10:59:37 -0700 (PDT)
Received: from pluto (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B4E7B3F59C;
        Mon,  2 Oct 2023 10:58:56 -0700 (PDT)
Date:   Mon, 2 Oct 2023 18:58:55 +0100
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     Nikunj Kela <quic_nkela@quicinc.com>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Brian Masney <bmasney@redhat.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "andersson@kernel.org" <andersson@kernel.org>,
        "konrad.dybcio@linaro.org" <konrad.dybcio@linaro.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>
Subject: Re: [PATCH v4 0/4] Add qcom hvc/shmem transport support
Message-ID: <ZRsE3zQI9Z8AfYqG@pluto>
References: <20230718160833.36397-1-quic_nkela@quicinc.com>
 <20230911194359.27547-1-quic_nkela@quicinc.com>
 <0efe305e-031b-bdf5-0268-ca1c6d562653@quicinc.com>
 <20230918151552.n3jvw2qqi5tmyfbb@bogus>
 <ZQhysWhFtR68iVMa@brian-x1>
 <20230919085612.gdmpze6c6stvammg@bogus>
 <74725381-bb13-2550-efd3-224e51af49d2@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <74725381-bb13-2550-efd3-224e51af49d2@quicinc.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 02, 2023 at 10:31:27AM -0700, Nikunj Kela wrote:
> 
> On 9/19/2023 1:56 AM, Sudeep Holla wrote:
> > On Mon, Sep 18, 2023 at 11:54:25AM -0400, Brian Masney wrote:
> > > On Mon, Sep 18, 2023 at 04:15:52PM +0100, Sudeep Holla wrote:
> > > > On Mon, Sep 18, 2023 at 08:01:26AM -0700, Nikunj Kela wrote:
> > > > > Gentle Ping!
> > > > > 
> > > > I will take a look at this later this week. That said, I am unable be
> > > > gauge the urgency based on you ping here. You have shown the same urgency
> > > > last time for a feature that I queued promptly just to know that it was
> > > > abandon within couple of days. So I don't want to rush here simply based
> > > > on the number of pings here. I need to understand that it is really that
> > > > important. For now, I am thinking of skipping even v6.7 just to allow
> > > > some time for Qcom to make up its mind and be absolutely sure this is what
> > > > they *really* want this time.
> > > Hi Sudeep,
> > > 
> > > Red Hat is interested in this patch set. Qualcomm is moving one of their
> > > automotive platforms over to use SCMI and this will appear in that
> > > product.
> > > 
> > Thanks Brian, I trust Redhat over Qcom 😄. I will try to review and enable
> > progress later this week. We can try to target next merge window.
> > 
> > --
> > Regards,
> > Sudeep
> Gentle Ping...

Looking at this tomorrow.

Thanks,
Cristian
