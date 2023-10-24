Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B37B67D5C1F
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 22:07:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344200AbjJXUHx convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 24 Oct 2023 16:07:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344337AbjJXUHv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 16:07:51 -0400
Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F5E410E0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 13:07:48 -0700 (PDT)
Received: from omf01.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay04.hostedemail.com (Postfix) with ESMTP id 0F93A1A0665;
        Tue, 24 Oct 2023 20:07:47 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf01.hostedemail.com (Postfix) with ESMTPA id D75A46000F;
        Tue, 24 Oct 2023 20:07:44 +0000 (UTC)
Message-ID: <5c90cc43b65149f92ab92e04c7c276dbba649222.camel@perches.com>
Subject: Re: [PATCH] checkpatch: allow tags between co-developed-by and
 their sign-off
From:   Joe Perches <joe@perches.com>
To:     Przemek Kitszel <przemyslaw.kitszel@intel.com>,
        Andy Whitcroft <apw@canonical.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Jacob Keller <jacob.e.keller@intel.com>,
        linux-kernel@vger.kernel.org
Date:   Tue, 24 Oct 2023 13:07:44 -0700
In-Reply-To: <5258664f-1f1f-6f3d-33ca-c3b2d60601b6@intel.com>
References: <20231020132156.37882-1-przemyslaw.kitszel@intel.com>
         <fbd86466d325055846e5d63f62ca1dc8613ba80d.camel@perches.com>
         <5258664f-1f1f-6f3d-33ca-c3b2d60601b6@intel.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Stat-Signature: xxnq8iubdidecxjogpkg3iyw9d51fe9y
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: D75A46000F
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1/eGlMCUmqbeetqrx/tNso+cLeulOtVGuo=
X-HE-Tag: 1698178064-162175
X-HE-Meta: U2FsdGVkX19wdizdAlyVQDjmyrRNa+rttLgDrlSqV7CEn4pBp5IafbxjE12TD6cazfkKpIHK0R17gcgvtGuuKXCchwg5DN9o9kI8wl2T3m2oedW5mTaAknCTHEyPepDb+rRElkS2iF+ftC+wSDe1DL4AqgFcazev5Hs0pgDtHfl9VUP6l4GqwfAxdnl94endG81N9F+0ir3in5IYFRdu4s/a3tuXag1l3E+0peH7e5smvDF7UjmyUe5IlLJ9QmJeOl6OBDB13azHDst/OyAeL1xCcIYhBuQqbJSnaB86j3KKhgknzRCSJtDDP1WdQUjNOo/JTmhebhi9cyAXbmx/pZPOkDAgFX8m
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2023-10-23 at 11:24 +0200, Przemek Kitszel wrote:
> On 10/21/23 00:34, Joe Perches wrote:
> > On Fri, 2023-10-20 at 15:21 +0200, Przemek Kitszel wrote:
> > > Allow additional tags between Co-developed-by: and Signed-off-by:.
> > > Bump severity of missing SoB to ERROR.
[]
> > Unless this is accepted by various process folk,
> > and the documentation for it updated, I think this
> > should not be applied.
> 
> I will post v2 with docs updated. Would make it clear in commit message
> that immediateness of SoB after CdB was important for humans checking
> presence of both manually, and checkpatch has adopted such requirement
> for it's own comfort.

checkpatch does not adopt stuff "for it's own comfort".

