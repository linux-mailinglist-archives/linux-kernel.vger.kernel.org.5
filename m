Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE4627DB1C4
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 02:11:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230150AbjJ3BIE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Oct 2023 21:08:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjJ3BID (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Oct 2023 21:08:03 -0400
X-Greylist: delayed 1119 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 29 Oct 2023 18:07:59 PDT
Received: from smtp.bekkoame.ne.jp (lbkksmtpnat.bekkoame.ne.jp [150.95.255.128])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 71B78BC
        for <linux-kernel@vger.kernel.org>; Sun, 29 Oct 2023 18:07:59 -0700 (PDT)
Received: from smtp.3web.ne.jp (localhost [127.0.0.1])
        by smtp.bekkoame.ne.jp (Postfix) with ESMTP id 809221042B9
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 09:45:49 +0900 (JST)
Received: from [127.0.0.1] (unknown [104.215.52.205])
        by mx1.tky.3web.ne.jp (Postfix) with ESMTPA id 78DA41042AF
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 09:45:49 +0900 (JST)
Content-Type: text/plain; charset=utf-8
From:   =?UTF-8?Q?vger=2Ekernel=2Eorg=E3=83=A1=E3=83=BC?=
         =?UTF-8?Q?=E3=83=AB=E9=80=9A=E7=9F=A5=E3=82=B5?=
         =?UTF-8?Q?=E3=83=BC=E3=83=93=E3=82=B9?= <te2@tky.3web.ne.jp>
To:     linux-kernel@vger.kernel.org
Subject: =?UTF-8?Q?=E3=83=A1=E3=83=BC=E3=83=AB=E3=80=90linu?=
 =?UTF-8?Q?x-kernel=40vger=2Ekernel=2Eorg=E3=80=91?=
 =?UTF-8?Q?=E3=81=AE=E8=A8=AD=E5=AE=9A=E7=A2=BA?=
 =?UTF-8?Q?=E8=AA=8D=E3=81=AE=E3=81=8A=E9=A1=98?= =?UTF-8?Q?=E3=81=84?=
Message-ID: <55a09474-3fb6-6ba3-538e-67ca38cf88a3@tky.3web.ne.jp>
X-Priority: 1 (Highest)
X-Msmail-Priority: High
Importance: High
Content-Transfer-Encoding: base64
Date:   Mon, 30 Oct 2023 00:45:49 +0000
MIME-Version: 1.0
X-Spam-Status: No, score=3.7 required=5.0 tests=BAYES_99,BAYES_999,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4oC744GT44Gu44Oh44O844OrIO+8iFZnZXLvvInkvJrlk6Hjga7nmobmp5jjgavlrpvjgabjgZ/j
goLjga7jgafjgZnjgIINCuKAu+OBk+OBruODoeODvOODq+OBuOOBrui/lOS/oeOBr+OBlOmBoOaF
ruOBj+OBoOOBleOBhOOAgg0KLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0gLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCjIwMjPlubQxMOac
iDMw5pelDQoNCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg44OJ44Oh44Kk
44Oz44Oh44Oz44OQ44O8Og0KDQrlubPntKDjgojjgornpZ7lpYjlt53lpKflrabjgrXjg7zjg5Pj
grnjgpLjgZTliKnnlKjjgYTjgZ/jgaDjgY3oqqDjgavjgYLjgorjgYzjgajjgYbjgZTjgZbjgYTj
gb7jgZnjgIINCg0K44OT44OD44Kw44Ot44O844OW77yIVmdlcu+8ieODoeODvOODq+OAkGxpbnV4
LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmfjgJHjga7jgrvjgq3jg6Xjg6rjg4bjgqPlvLfljJbjga7j
gZ/jgoHjgIHjg6Hjg7zjg6vjgr3jg5Xjg4jjga7oqK3lrprjgpLlpInmm7TjgZXjgZvjgabjgYTj
gZ/jgaDjgY3jgb7jgZnjgIINCuODoeODvOODq+OCveODleODiOOBruioreWumuOCkuOBlOeiuuiq
jeOBhOOBn+OBoOOBjeOAgeS7iuW+jOOCguOBlOWIqeeUqOOBhOOBn+OBoOOBkeOCi+OCiOOBhuio
reWumuOCkuWkieabtOOBl+OBpuOBj+OBoOOBleOBhOOAgg0KDQoNCuODoeODvOODq+OCveODleOD
iOOBruioreWumueiuuiqjeODu+WkieabtOaWueazleOBq+OBpOOBhOOBpuOBr+OAgeS7peS4i+OB
ruODquODs+OCr+OCkuOBlOWPgueFp+OBj+OBoOOBleOBhOOAgg0KDQrjg6Hjg7zjg6vjgr3jg5Xj
g4jjga7oqK3lrprnorroqo3jg7vlpInmm7Tmlrnms5UNCg0KaHR0cHM6Ly9rYi1hdC5jb20vbWFp
bC5hbXNlcnZlci5qcC9VSS9Mb2dpbj91aWQ9bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0K
DQrvvIrvvIrvvIrvvIrvvIrvvIrvvIrvvIrvvIrvvIrvvIrvvIrvvIrvvIrvvIrvvIrvvIrvvIrv
vIrvvIrvvIrvvIoNCuOBlOWNlOWKm+OBguOCiuOBjOOBqOOBhuOBlOOBluOBhOOBvuOBmeOAgg0K
aHR0cHM6Ly93d3cudmdlci5rZXJuZWwub3JnL2NvbnRhY3QvdXNlci8NCu+8iu+8iu+8iu+8iu+8
iu+8iu+8iu+8iu+8iu+8iu+8iu+8iu+8iu+8iu+8iu+8iu+8iu+8iu+8iu+8iu+8iu+8ig==
