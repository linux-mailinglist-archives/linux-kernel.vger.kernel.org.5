Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 527E37B11E2
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 07:02:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230210AbjI1FCF convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 28 Sep 2023 01:02:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjI1FCC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 01:02:02 -0400
Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D5B5BF;
        Wed, 27 Sep 2023 22:01:57 -0700 (PDT)
Received: from omf20.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay10.hostedemail.com (Postfix) with ESMTP id 970ECC0772;
        Thu, 28 Sep 2023 05:01:55 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf20.hostedemail.com (Postfix) with ESMTPA id A27F72002B;
        Thu, 28 Sep 2023 05:01:52 +0000 (UTC)
Message-ID: <5707f3bef3ecd8220a8bf7c8b72c72c53e65b666.camel@perches.com>
Subject: Re: [PATCH v2 0/2] get_maintainer: add patch-only keyword matching
From:   Joe Perches <joe@perches.com>
To:     Justin Stitt <justinstitt@google.com>
Cc:     linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        geert@linux-m68k.org, gregkh@linuxfoundation.org,
        workflows@vger.kernel.org, mario.limonciello@amd.com
Date:   Wed, 27 Sep 2023 22:01:51 -0700
In-Reply-To: <20230928-get_maintainer_add_d-v2-0-8acb3f394571@google.com>
References: <20230928-get_maintainer_add_d-v2-0-8acb3f394571@google.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: A27F72002B
X-Stat-Signature: nmbysq8niacnf8eookyd1ods74gibotb
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX18JnaQBmGFWWxnvUqOvdh1cJNl8atOsHw4=
X-HE-Tag: 1695877312-899003
X-HE-Meta: U2FsdGVkX18J317x1z0ZMpq5Bv1hdzAbhrf3ziK4A2g2x5EYDdvDTB96EzPQT2uuHCdO7ogbHo7lc3qJEKVz3JZ6+yEOJDThS6qI0hxxMTpaov/2+Kx1DnDgm/cx+J6vhpHuWkyzuw6WgXjyWKz/1WVBRlQWHmCy4oYyK70ue6xZEsJ9aSb8OJi3ThzcEdBUxIiWnelHQ7GEvy3PKuYU+IvJ5ffKC8hH2sV0FFMnkrrvsc+RwSSQiAB6XJfdNSIDORJ7clObR8V5UHwEIasVb2fD1oergUwzNNztZxBsVkJ78K3Cyow7RvP6CmZOK93j
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2023-09-28 at 04:23 +0000, Justin Stitt wrote:
> Changes in v2:
> - remove formatting pass (thanks Joe) (but seriously the formatting is
>   bad, is there opportunity to get a formatting pass in here at some
>   point?)

Why?  What is it that makes you believe the formatting is bad?

