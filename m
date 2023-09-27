Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E92A57AF927
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 06:19:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbjI0ETQ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 27 Sep 2023 00:19:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbjI0ESL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 00:18:11 -0400
Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AC5816EBA
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 20:26:29 -0700 (PDT)
Received: from omf04.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay03.hostedemail.com (Postfix) with ESMTP id D35B7A075E;
        Wed, 27 Sep 2023 03:26:27 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf04.hostedemail.com (Postfix) with ESMTPA id F3F4520023;
        Wed, 27 Sep 2023 03:26:23 +0000 (UTC)
Message-ID: <ede8cc10c489bc4ac02e10b719a8d14e10c65911.camel@perches.com>
Subject: Re: [PATCH 2/3] get_maintainer: run perltidy
From:   Joe Perches <joe@perches.com>
To:     Justin Stitt <justinstitt@google.com>
Cc:     linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        geert@linux-m68k.org, gregkh@linuxfoundation.org,
        workflows@vger.kernel.org, mario.limonciello@amd.com
Date:   Tue, 26 Sep 2023 20:26:23 -0700
In-Reply-To: <20230927-get_maintainer_add_d-v1-2-28c207229e72@google.com>
References: <20230927-get_maintainer_add_d-v1-0-28c207229e72@google.com>
         <20230927-get_maintainer_add_d-v1-2-28c207229e72@google.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Stat-Signature: og6uis8b7ssjfekhjbxod6ftu1mqeikq
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: F3F4520023
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_NONE,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
        version=3.4.6
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX18BUfsULc/ZZFpga5G4CWQWTQBmgY2PJFw=
X-HE-Tag: 1695785183-283402
X-HE-Meta: U2FsdGVkX1/sYBVQpkJ3ZqFHvqXC8Kdqx+bT5Eqt1ScpEBv96t4Ir/FZkl5ho3MwQEAsLcDUgBRiTNNHm3u+oxGi4dbg6lcYzbEOJ2MpR9YKeMUv4AkuVME7vEf0FZBDjGXtYtmtEr2QPh7BIwgFcpaX6v8EYuekm/XKBD/K9eVMsqNk+LmoJQQ1qRkEzICbb8lIPylLZQLS57/PfmANNbVfLwyiY1ixZbti08+TlYWqtbBzTeulsK7c666X4F7ifApECJlU16HaWtCtKAFN1xPxNoCl4fy9YHBhN45hw7xrFR74qBg/wxv6ee9Qo4Du
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2023-09-27 at 03:19 +0000, Justin Stitt wrote:
> I'm a first time contributor to get_maintainer.pl and the formatting is
> suspicious. I am not sure if there is a particular reason it is the way
> it is but I let my editor format it and submitted the diff here in this
> patch.

Capital NACK.  Completely unnecessary and adds no value.

