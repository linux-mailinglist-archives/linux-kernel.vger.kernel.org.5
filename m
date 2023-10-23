Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF45C7D3941
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 16:25:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230367AbjJWOZS convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 23 Oct 2023 10:25:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230158AbjJWOZQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 10:25:16 -0400
Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 318A6102;
        Mon, 23 Oct 2023 07:25:14 -0700 (PDT)
Received: from omf09.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay06.hostedemail.com (Postfix) with ESMTP id 6BB93B599B;
        Mon, 23 Oct 2023 14:25:12 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf09.hostedemail.com (Postfix) with ESMTPA id 7984A20025;
        Mon, 23 Oct 2023 14:25:09 +0000 (UTC)
Message-ID: <04bad51f7b54769dd63d2d1d5ea90ece2f96ef36.camel@perches.com>
Subject: Re: [PATCH] checkpatch: allow tags between co-developed-by and
 their sign-off
From:   Joe Perches <joe@perches.com>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc:     Andy Whitcroft <apw@canonical.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Sean Christopherson <seanjc@google.com>,
        workflows@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        Jacob Keller <jacob.e.keller@intel.com>
Date:   Mon, 23 Oct 2023 07:25:07 -0700
In-Reply-To: <CAKXUXMyOk+06ZRc7gvYMA=KHvZZp1FXiCJC5Tp9M=SUQfQnBVQ@mail.gmail.com>
References: <20231023102846.14830-1-przemyslaw.kitszel@intel.com>
         <CAKXUXMyOk+06ZRc7gvYMA=KHvZZp1FXiCJC5Tp9M=SUQfQnBVQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Stat-Signature: a5y5pay5cmc4pimenff3i1cgykofj9sw
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: 7984A20025
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX19aCX/HWXmpoEvOiqEBil3+91tMr32DOIE=
X-HE-Tag: 1698071109-951407
X-HE-Meta: U2FsdGVkX1+oNTAN+ncEQY4EOJeUTXYW/sBIqlTgPAeXBRRZOvp9n2cALS+ZiPfMeuaHSI2w6nv/PMrQa9fvGVgZrVUivorEffFKZ52WdMynP0IIrdRljQ1m1WUzaiZhgaSjo5LTeOsOiH9v5ALn9viEA8NUAEv8vbtY4f7QfciVH1Y0wByERPIqsVxAzhFoZf/AZ0DcGt6TYvm9+J7VkH1qBO2RI3UU6oMw0L+oBKZCiI3oj3P1excPPeGlOLzLnBfqBaffQFnoMjLU5P+x1KtSRoh66w2hsT3OvGXPygqJyniifV2M0m+u/14CrbKu81X6NuY4Kg1nQEeNVcsDOljqRuDJScop
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2023-10-23 at 16:16 +0200, Lukas Bulwahn wrote:
> On Mon, Oct 23, 2023 at 12:29 PM Przemek Kitszel <przemyslaw.kitszel@intel.com> wrote:
> > Allow additional tags between Co-developed-by: and Signed-off-by:.

I think this unnecessary and not particularly useful as well.
> 

> I see many potential areas of work for the checkpatch script

List them please.

