Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D34D77F43C1
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 11:26:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229513AbjKVK0r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 05:26:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343854AbjKVKZj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 05:25:39 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 129E2110
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 02:25:31 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FBE3C433C9;
        Wed, 22 Nov 2023 10:25:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700648731;
        bh=YcBYpnCa+wkhXfDEX/YvQLtmcej4A0EtnL4uPGNb79A=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=M9AbEBhV74MsAV+sbu/RZaUqRXZRqcx0u90OD5OVpO1NpvfQJiPcMMzNYhtXBtzMy
         VGnYVx5KrEWFiqWD2E2wYhmTIcJ3uMAzag5/Xcl0BvMJL5U+N8cC4m4tmrnmWjRLyr
         QhnSWI2L5fxZpFzg7MBCjbpdtFsVLEnZ08erif+3wSklDMsrp0h6RGf5t8nh+HR3A4
         iKpOKB02TGfOYXPLi0N8q/XjTKS9Cp/BeDCNJBmYtSc4SppOq79WV1b93jpcIix5vw
         rUCARA6OJwmlK/AHEdgdogbvbTS58qamUUT6Ki9ebhouuyVLbzuPfvUEUwo4wtvKy/
         5B11dZRlKJVPw==
Date:   Wed, 22 Nov 2023 11:25:28 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Luke Jones <luke@ljones.dev>
cc:     Denis Benato <benato.denis96@gmail.com>,
        benjamin.tissoires@redhat.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] hid-asus: reset the backlight brightness level on
 resume
In-Reply-To: <MRNH4S.965MCNIAPCDV2@ljones.dev>
Message-ID: <nycvar.YFH.7.76.2311221125221.29220@cbobk.fhfr.pm>
References: <20231117011556.13067-1-luke@ljones.dev> <b4356286-368a-49ec-b1f8-d7e5e4afdc25@gmail.com> <nycvar.YFH.7.76.2311210951340.29220@cbobk.fhfr.pm> <MRNH4S.965MCNIAPCDV2@ljones.dev>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Nov 2023, Luke Jones wrote:

> >> I want to express my gratitude toward Luke for his guidance and his help
> >>  in submitting this fix.
> >> 
> >>  I confirm those patches were sent in my behalf.
> > 
> > Luke, as you were in the supply chain of the patches, could you please
> > provide Signed-off-by: tags so that I can add them into the chain?
> 
> Signed-off-by: Luke D. Jones <luke@ljones.dev>

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs

