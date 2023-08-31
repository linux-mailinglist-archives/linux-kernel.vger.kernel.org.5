Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95F5C78E6DB
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 08:55:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235664AbjHaGzg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 02:55:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242970AbjHaGzd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 02:55:33 -0400
Received: from mail-40137.protonmail.ch (mail-40137.protonmail.ch [185.70.40.137])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1863CDD
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 23:55:26 -0700 (PDT)
Date:   Thu, 31 Aug 2023 06:55:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
        s=protonmail; t=1693464924; x=1693724124;
        bh=l7rOC5mf7vAtnSYvO8RqD0yLOsDDfEM1LUgZ/9108+s=;
        h=Date:To:From:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=CCaDAGMnAMwAApfk/Mxv8dwpAWhd8VkU8lZQtBUG3g7kPbzAC3JisQkTnuxXGeOTH
         EhCWR7B23+oLi6mxoDtbqFhmHKrVg0Bs7a+6vDPjP+neAakZP37RO3HHVZItEeB35m
         H8i1fPfZPLOe/Ind3u4KFPdKGlVmGwWStpi21id+caVYGYHrfBSn0w/J4kchfwJQmR
         +Ol/wl1SKbt3FHpqpsK5e1r7feaRXTOQOLJVBR4MOLnnEEl59+m1U4nLJkhumaV3l9
         UVVAIvtnA+IWMjeRJKlrw0MSps1sNs9gvvJ/cJeWCyXqIsd0Wj9h3C6qusCc/j3gSn
         GqgOuDM0zeCfA==
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   youngbludproductions <youngbludproductions@proton.me>
Subject: Re: [PATCH] Update: Fixing SSH Hardware Key Issue
Message-ID: <tAhUQSc5uwwjQtY_kdRUe79bpsl4gT2YVxWd3n59lBqUkyhPfEh_rj5lGKxWhxCNYzKJTziLWTYS75zRm8hXJ9AvF46WCMePw-1OybIrxsE=@proton.me>
In-Reply-To: <TQT4YufaV3YuStoFkD5gAcplDIsO76FYEqGQqYzLxrWzgNJ2FwqI__DjgyBZlPSOV6BVJXE54Wf8zroK728hlDXV2Mn5wt9kw2iovRBGPuI=@proton.me>
References: <TQT4YufaV3YuStoFkD5gAcplDIsO76FYEqGQqYzLxrWzgNJ2FwqI__DjgyBZlPSOV6BVJXE54Wf8zroK728hlDXV2Mn5wt9kw2iovRBGPuI=@proton.me>
Feedback-ID: 85224644:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Bagas,

It was necessary to fix my issues.=20

Best regards,
Clyde
