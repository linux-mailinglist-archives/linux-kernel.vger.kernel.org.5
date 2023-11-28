Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81C207FAE4A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 00:26:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233657AbjK0XYu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 18:24:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbjK0XYt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 18:24:49 -0500
Received: from vps.thesusis.net (vps.thesusis.net [34.202.238.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BC841AA
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 15:24:54 -0800 (PST)
Received: by vps.thesusis.net (Postfix, from userid 1000)
        id 64FAA14ACC1; Mon, 27 Nov 2023 18:24:53 -0500 (EST)
From:   Phillip Susi <phill@thesusis.net>
To:     Alex Deucher <alexdeucher@gmail.com>,
        Christian =?utf-8?Q?K=C3=B6nig?= <christian.koenig@amd.com>
Cc:     Christian =?utf-8?Q?K=C3=B6nig?= 
        <ckoenig.leichtzumerken@gmail.com>,
        Dave Airlie <airlied@gmail.com>,
        Linux regressions mailing list <regressions@lists.linux.dev>,
        linux-kernel@vger.kernel.org,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        Luben Tuikov <luben.tuikov@amd.com>,
        dri-devel@lists.freedesktop.org,
        Alex Deucher <alexander.deucher@amd.com>
Subject: Re: Radeon regression in 6.6 kernel
In-Reply-To: <CADnq5_NBfeAXEyQw0gnSd67=tR-bUKg8w=10+4z9pGGuRnP9uw@mail.gmail.com>
References: <87edgv4x3i.fsf@vps.thesusis.net>
 <559d0fa5-953a-4a97-b03b-5eb1287c83d8@leemhuis.info>
 <CAPM=9tw-8pQWFso0zuLqpsqd5BSHWtc4As9ttdjY-DDr70EMqQ@mail.gmail.com>
 <bdb238b6-60c7-4f26-81d0-9e62cd5dd326@gmail.com>
 <CADnq5_NVGS1XykxGxpcu_bpPbzboCUJQkcCF3r+0N9a23KUgiQ@mail.gmail.com>
 <96e2e13c-f01c-4baf-a9a3-cbaa48fb10c7@amd.com>
 <CADnq5_NBfeAXEyQw0gnSd67=tR-bUKg8w=10+4z9pGGuRnP9uw@mail.gmail.com>
Date:   Mon, 27 Nov 2023 18:24:53 -0500
Message-ID: <87jzq2ixtm.fsf@vps.thesusis.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alex Deucher <alexdeucher@gmail.com> writes:

>> In that case those are the already known problems with the scheduler
>> changes, aren't they?
>
> Yes.  Those changes went into 6.7 though, not 6.6 AFAIK.  Maybe I'm
> misunderstanding what the original report was actually testing.  If it
> was 6.7, then try reverting:
> 56e449603f0ac580700621a356d35d5716a62ce5
> b70438004a14f4d0f9890b3297cd66248728546c

At some point it was suggested that I file a gitlab issue, but I took
this to mean it was already known and being worked on.  -rc3 came out
today and still has the problem.  Is there a known issue I could track?

